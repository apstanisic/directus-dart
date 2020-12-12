import 'dart:async';

import 'package:dio/dio.dart';
import 'package:directus/src/store.dart';

class _LoginResponse {
  late String accessToken;
  late int accessTokenExpiresAt;
  late String refreshToken;

  _LoginResponse(Map data) {
    accessToken = data['access_token'];
    accessTokenExpiresAt = data['expires'];
    refreshToken = data['refresh_token'];
  }
}

class AuthHandler {
  Dio client;
  DirectusStore store;
  String? _accessToken;
  Timer? _timer;

  AuthHandler({required this.client, required this.store});

  /// Refresh access token before expiration
  Future<void> refresh() async {
    _timer?.cancel();
    final expiresAtString = await store.getItem('access_token_expires_at');
    final refreshToken = await store.getItem('refresh_token');
    if (expiresAtString == null || refreshToken == null) return;
    final expiresAt = DateTime.fromMillisecondsSinceEpoch(int.parse(expiresAtString));

    if (expiresAt.isAfter(DateTime.now().add(Duration(seconds: 10)))) {
      final remainingTime = expiresAt.difference(DateTime.now().add(Duration(seconds: 10)));
      _timer = Timer(remainingTime, refresh);
      return;
    }

    final response = await client.post('/auth/refresh', data: {
      'mode': 'json',
      'refresh_token': refreshToken,
    });

    final responseData = _LoginResponse(response.data['data']);
    token = responseData.accessToken;
    _timer = Timer(Duration(milliseconds: responseData.accessTokenExpiresAt - 10000), refresh);
  }

  String? get token {
    return _accessToken;
  }

  set token(String? token) {
    _accessToken = token;

    if (token == null) {
      client.options.headers.remove('Authorization');
    } else {
      client.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  /// Attempt to login user
  Future<_LoginResponse> login(
      {required String email, required String password, String? otp}) async {
    _timer?.cancel();
    final data = {'email': email, 'password': password, 'mode': 'json'};
    if (otp != null) {
      data['otp'] = otp;
    }

    final response = await client.post('/auth/login', data: data);
    final responseData = _LoginResponse(response.data['data']);
    token = responseData.accessToken;
    final expiresAt = DateTime.now()
        .add(Duration(milliseconds: responseData.accessTokenExpiresAt))
        .millisecondsSinceEpoch;

    await store.setItem('access_token', responseData.accessToken);
    await store.setItem('access_token_expires_at', expiresAt.toString());
    await store.setItem('refresh_token', responseData.refreshToken);

    return responseData;
  }

  /// Logout user
  Future<void> logout() async {
    _timer?.cancel();
    await client.post('/auth/logout');
    token = null;
  }

  /// Request password
  Future<void> requestPassword(String email) async {
    await client.post('/auth/password/request', data: {'email': email});
  }

  /// Reset password
  Future<void> resetPassword({required String token, required String password}) async {
    await client.post('/auth/password/reset', data: {'token': token, 'password': password});
  }
}
