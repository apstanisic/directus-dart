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
  final Dio _refreshClient;

  /// Data returned from login.
  ///
  /// If there is no data, then user is not logged in
  AuthResponse? _tokens;

  /// Storage used for storing data returned from login.
  AuthStorage storage;

  /// Manipulate current user.
  ///
  /// This value is [CurrentUser] when user is logged in, and [null] othervise.
  CurrentUser? currentUser;

  /// Enable and disable two factor authentication.
  ///
  /// This value is [Tfa] when user is logged in, and [null] othervise.
  Tfa? tfa;

  /// Class for requesting and setting forgotten password.
  late ForgottenPassword forgottenPassword;

  /// Event listeners that will be called on auth event.
  final List<ListenerFunction> _listeners = [];

  /// Key used for differentiating between instances storage
  final String? _key;

  /// Auth constructor.
  ///
  /// Requires [Dio] client that makes HTTP requests, [DirectusStorage] for storing auth data,
  /// and [Dio] client that is used for making request for new access token.
  AuthHandler(
      {required this.client,
      required DirectusStorage storage,
      required Dio refreshClient,
      String? key})
      : _key = key,
        storage = AuthStorage(storage),
        forgottenPassword = ForgottenPassword(client: client),
        _refreshClient = refreshClient {
    // Refresh url is same as normal url.
    _refreshClient.options.baseUrl = client.options.baseUrl;
    // Get new access token if current is expired.
    client.interceptors.add(InterceptorsWrapper(onRequest: refreshExpiredTokenInterceptor));
  }

  /// Add listener when auth status changes
  @experimental
  set onChange(ListenerFunction fn) => _listeners.add(fn);

  /// Initializes [AuthHandler], by getting data from cold storage.
  ///
  /// This method should be called right after constructor, othervise logged in user
  /// might appear as not logged in, because data isn't fetched from cold storage.
  Future<void> init() async {
    tokens = await storage.getLoginData();

    if (tokens != null) {
      currentUser = CurrentUser(client: client);
      tfa = Tfa(client: client);
    }

    await _callEventListeners('init', tokens);
  }

  /// Check if user is logged in.
  bool get isLoggedIn => _tokens != null;

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

    try {
      final dioResponse = await client.post('auth/login', data: data);
      final loginDataResponse = AuthResponse.fromResponse(dioResponse);
      await storage.storeLoginData(loginDataResponse);

      tokens = loginDataResponse;
      currentUser = CurrentUser(client: client);
      tfa = Tfa(client: client);

      await _callEventListeners('login', loginDataResponse);
    } catch (e) {
      throw DirectusError.fromDio(e);
    }
  }

  /// Logout user
  Future<void> logout() async {
    if (tokens == null) throw DirectusError(message: 'User is not logged in.');
    try {
      await client.post('auth/logout', data: {'refresh_token': tokens!.refreshToken});
    } catch (e) {
      throw DirectusError.fromDio(e);
    } finally {
      currentUser = null;
      tfa = null;
      tokens = null;
      await _callEventListeners('logout');
    }
  }

  /// Get login data
  AuthResponse? get tokens => _tokens;

  /// Set login data in memory. For storing data permanently, use [storage]
  ///
  /// This will set data in memory and set access token for client.
  set tokens(AuthResponse? data) {
    _tokens = data;

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
    if (tokens == null) return options;

    // If there are less then 5 seconds in access token, get new token
    if (!tokens!.accessTokenExpiresAt.subtract(Duration(seconds: 10)).isBefore(DateTime.now())) {
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
    if (tokens == null) return null;
    client.lock();

    try {
      final response = await _refreshClient.post('auth/refresh', data: {
        'mode': 'json',
        'refresh_token': tokens!.refreshToken,
      });
      final loginDataResponse = AuthResponse.fromResponse(response);
      await storage.storeLoginData(loginDataResponse);
      tokens = loginDataResponse;
    } catch (e) {
      client.unlock();
      throw DirectusError.fromDio(e);
    }
    client.unlock();
    await _callEventListeners('refresh', tokens);
    return tokens;
  }

  /// Call all listeners after event happened.
  Future<void> _callEventListeners(String type, [AuthResponse? data]) async {
    for (var i = 0; i < _listeners.length; i++) {
      await _listeners[i].call(type, data);
    }
  }
}
