import 'dart:async';

import 'package:dio/dio.dart';
import 'package:directus/src/handlers/auth/_auth_storage.dart';
import 'package:directus/src/handlers/auth/_current_user.dart';
import 'package:directus/src/handlers/auth/_tfa.dart';
import 'package:directus/src/stores/directus_store.dart';

import '_auth_response.dart';

class AuthHandler {
  /// Http client
  final Dio client;

  /// Http client that is used to get new access token
  late final Dio _tokenClient;

  /// Data returned from login
  ///
  /// If there is no data, then user is not logged in
  AuthResponse? _loginData;

  /// Interceptor that will fetch new access token when current is expired
  InterceptorsWrapper? interceptor;

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

  AuthHandler({
    required this.client,
    required DirectusStorage storage,
    Dio? tokenClient,
  }) : storage = AuthStorage(storage) {
    // Get new access token if current is expired.
    interceptor = InterceptorsWrapper(onRequest: getNewTokenInInterceptor);
    client.interceptors.add(interceptor);
    if (tokenClient != null) {
      _tokenClient = tokenClient;
    } else {
      _tokenClient = Dio(BaseOptions(baseUrl: client.options.baseUrl));
    }
  }

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

    final dioResponse = await client.post('/auth/login', data: data);
    final loginDataResponse = AuthResponse.fromResponse(dioResponse);
    await storage.storeLoginData(loginDataResponse);
    loginData = loginDataResponse;
    currentUser = CurrentUser(client: client);
    tfa = Tfa(client: client);
  }

  /// Logout user
  Future<void> logout() async {
    // _timer?.cancel();
    if (loginData != null) {
      await client.post('/auth/logout');
      loginData = null;
      client.interceptors.remove(interceptor);
      interceptor = null;
      currentUser = null;
      tfa = null;
    }
  }

  /// Request password to be sent to your email
  Future<void> requestPassword(String email) async {
    await client.post('/auth/password/request', data: {'email': email});
  }

  /// Reset password
  ///
  /// Provide [token] and new [password] that you want to set.
  Future<void> resetPassword({required String token, required String password}) async {
    await client.post('/auth/password/reset', data: {'token': token, 'password': password});
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

  Future<RequestOptions> getNewTokenInInterceptor(RequestOptions options) async {
    // If user is not logged in, just do request normally
    if (loginData == null) return options;

    // If there are less then 5 seconds in access token, get new token
    if (loginData!.accessTokenExpiresAt.add(Duration(seconds: 5)).isAfter(DateTime.now())) {}
    client.lock();

    final response = await _tokenClient.post('/auth/refresh', data: {
      'mode': 'json',
      'refresh_token': loginData!.refreshToken,
    });
    final loginDataResponse = AuthResponse.fromResponse(response);
    await storage.storeLoginData(loginDataResponse);
    loginData = loginDataResponse;
    options.headers['Authorization'] = loginData!.accessToken;

    client.unlock();
    return options;
  }
}
