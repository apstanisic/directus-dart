import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/data_classes.dart';
import 'package:directus/src/modules/auth/_auth_storage.dart';
import 'package:directus/src/modules/auth/_current_user.dart';
import 'package:directus/src/modules/auth/_forgotten_password.dart';
import 'package:directus/src/modules/auth/_tfa.dart';
import 'package:meta/meta.dart';

import '_auth_response.dart';

/// Definition that any callback function must fullfill if it wants to be Auth callback.
///
/// [type] is either `login`, `logout`, `init` or `refresh`.
/// [data] is data returned from action. It can be [AuthResponse] for `login`, `init` and `refresh`,
/// and [Null] for `logout` and `init`. `init` will have value if user is logged in.
typedef ListenerFunction = Future<void> Function(String type, AuthResponse? data);

class AuthHandler {
  /// Http client
  final Dio client;

  /// Http client that is used to get new access token
  late final Dio _refreshClient;

  /// Data returned from login
  ///
  /// If there is no data, then user is not logged in
  AuthResponse? _loginData;

  /// Storage used for data returned from login.
  AuthStorage storage;

  /// Manipulate current user.
  ///
  /// This value is [Tfa] when user is logged in,
  /// and [null] when user is not logged in.
  CurrentUser? currentUser;

  /// Enable and disable two factor authentication.
  ///
  /// This value is [Tfa] when user is logged in,
  /// and [null] when user is not logged in.
  Tfa? tfa;

  /// Forgotten password.
  late ForgottenPassword forgottenPassword;

  List<ListenerFunction> listeners = [];

  AuthHandler({
    required this.client,
    required DirectusStorage storage,
    Dio? refreshClient,
  }) : storage = AuthStorage(storage) {
    forgottenPassword = ForgottenPassword(client: client);
    // Get new access token if current is expired.
    _refreshClient = refreshClient ?? Dio(BaseOptions(baseUrl: client.options.baseUrl));

    client.interceptors.add(InterceptorsWrapper(onRequest: refreshExpiredTokenInterceptor));
  }

  /// Add listener when auth status changes
  @experimental
  set onChange(ListenerFunction fn) => listeners.add(fn);

  /// Initializes [AuthHandler], by getting data from cold storage.
  ///
  /// This method should be called right after constructor, othervise logged in user
  /// might appear as not logged in, because data isn't fetched from cold storage.
  Future<void> init() async {
    loginData = await storage.getLoginData();
    if (loginData != null) {
      currentUser = CurrentUser(client: client);
      tfa = Tfa(client: client);
    }

    await _callListeners('init', loginData);
  }

  /// Check if user is logged in.
  bool get isLoggedIn => _loginData != null;

  /// Try to login user.
  Future<void> login({
    required String email,
    required String password,
    String? otp,
  }) async {
    final data = {
      'email': email,
      'password': password,
      'mode': 'json',
      if (otp != null) 'otp': otp
    };

    final dioResponse = await client.post('auth/login', data: data);
    final loginDataResponse = AuthResponse.fromResponse(dioResponse);
    await storage.storeLoginData(loginDataResponse);
    loginData = loginDataResponse;
    currentUser = CurrentUser(client: client);
    tfa = Tfa(client: client);

    await _callListeners('login', loginDataResponse);
  }

  /// Logout user
  Future<void> logout() async {
    // _timer?.cancel();
    if (loginData != null) {
      await client.post('auth/logout', data: {'refresh_token': loginData!.refreshToken});
      loginData = null;
      currentUser = null;
      tfa = null;
    }

    await _callListeners('logout');
  }

  /// Get login data
  AuthResponse? get loginData => _loginData;

  /// Set login data in memory. For storing data permanently, use [storage]
  ///
  /// This will set data in memory and set access token for client.
  set loginData(AuthResponse? data) {
    _loginData = data;

    if (data == null) {
      client.options.headers.remove('Authorization');
    } else {
      client.options.headers['Authorization'] = 'Bearer ${data.accessToken}';
    }
  }

  /// This is run before every request. It check if token is about to expire, and fetches new one.
  ///
  /// If user is logged in, and token has less the 5s ttl, SDK will refresh token,
  /// and update token in [client]. If for some reason refreshing fail, it will delete token
  /// from [client].
  @visibleForTesting
  Future<RequestOptions> refreshExpiredTokenInterceptor(RequestOptions options) async {
    // If user is not logged in, just do request normally
    if (loginData == null) return options;

    // If there are less then 5 seconds in access token, get new token
    if (!loginData!.accessTokenExpiresAt.subtract(Duration(seconds: 5)).isBefore(DateTime.now())) {
      return options;
    }

    final response = await manuallyRefresh();
    if (response?.accessToken != null) {
      options.headers['Authorization'] = response!.accessToken;
    } else {
      options.headers.remove('Authorization');
    }

    return options;
  }

  /// Refreshes access token.
  ///
  /// It checks if user is logged in,
  /// then locks Dio to don't make requests until we have new token,
  /// then send request for new access token,
  /// then set response to storage and memory,
  /// then unlocks Dio,
  /// then notifies all listeners.
  @experimental
  Future<AuthResponse?> manuallyRefresh() async {
    if (loginData == null) return null;
    client.lock();

    final response = await _refreshClient.post('auth/refresh', data: {
      'mode': 'json',
      'refresh_token': loginData!.refreshToken,
    });
    final loginDataResponse = AuthResponse.fromResponse(response);
    await storage.storeLoginData(loginDataResponse);
    loginData = loginDataResponse;
    client.unlock();
    await _callListeners('refresh', loginDataResponse);
    return loginDataResponse;
  }

  /// Call all listeners after event happened.
  Future<void> _callListeners(String type, [AuthResponse? data]) async {
    for (var i = 0; i < listeners.length; i++) {
      await listeners[i].call(type, data);
    }
  }
}
