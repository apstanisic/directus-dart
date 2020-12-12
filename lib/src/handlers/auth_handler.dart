import 'package:dio/dio.dart';
import 'package:directus/src/store.dart';

class _LoginResponse {
  late String accessToken;
  late int expires;
  late String refreshToken;

  _LoginResponse(Map data) {
    accessToken = data['access_token'];
    expires = data['expires'];
    refreshToken = data['refresh_token'];
  }
}

class AuthHandler {
  Dio client;
  DirectusStore store;
  String? _accessToken;

  AuthHandler({required this.client, required this.store});

  refresh() {}

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
    final data = {'email': email, 'password': password, 'mode': 'json'};
    if (otp != null) {
      data['otp'] = otp;
    }

    final response = await client.post('/auth/login', data: data);
    final responseData = _LoginResponse(response.data['data']);
    token = responseData.accessToken;
    final expiresAt = DateTime.now().add(Duration(milliseconds: responseData.expires)).toString();

    await store.setItem('access_token', responseData.accessToken);
    await store.setItem('expires_at', expiresAt);
    await store.setItem('refresh_token', responseData.refreshToken);

    return responseData;
  }

  /// Logout user
  Future<void> logout() async {
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
