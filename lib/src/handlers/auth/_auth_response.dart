import 'package:dio/dio.dart';

const _refreshTokenField = 'refresh_token';
const _accessTokenField = 'access_token';
const _accessTokenExpiresField = 'expires';

/// Response that is returned from login or refresh
class AuthResponse {
  late String refreshToken;
  late String accessToken;
  late int accessTokenMsValid;
  late DateTime accessTokenExpiresAt;

  AuthResponse.fromResponse(Response response) {
    final data = response.data?['data'];

    if (data == null) throw Exception('Login response is invalid.');

    final accessToken = data[_accessTokenField];
    final refreshToken = data[_refreshTokenField];
    final accessTokenMsValid = data[_accessTokenExpiresField];

    if (accessToken == null ||
        accessTokenMsValid == null ||
        refreshToken == null) {
      throw Exception('Login response is invalid.');
    }

    this.refreshToken = refreshToken;
    this.accessToken = accessToken;
    this.accessTokenMsValid = accessTokenMsValid;
    accessTokenExpiresAt =
        DateTime.now().add(Duration(milliseconds: accessTokenMsValid));
  }

  AuthResponse({
    required this.accessToken,
    required this.accessTokenExpiresAt,
    required this.accessTokenMsValid,
    required this.refreshToken,
  });
}
