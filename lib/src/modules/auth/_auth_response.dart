// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/directus_error.dart';

/// Response that is returned from login or refresh
class AuthResponse {
  /// Refresh token
  late String refreshToken;

  /// Access token
  late String accessToken;

  /// Access token time to live in seconds
  ///
  /// API returns duration in miliseconds, but value will be converted to seconds
  /// for easier use.
  late int accessTokenTtlInSeconds;

  /// [DateTime] when access token expires.
  ///
  /// It's using time of app time, not server time.
  late DateTime accessTokenExpiresAt;

  /// Constructor for manually creating object
  AuthResponse({
    required this.accessToken,
    required this.accessTokenExpiresAt,
    required this.accessTokenTtlInSeconds,
    required this.refreshToken,
  });

  /// Create [AuthResponse] from [Dio] [Response] object.
  AuthResponse.fromResponse(Response response) {
    final data = response.data?['data'];

    if (data == null) throw Exception('Login response is invalid.');

    final accessToken = data['access_token'];
    final refreshToken = data['refresh_token'];
    final accessTokenTtlInMs = data['expires'];

    if (accessToken == null || !(accessTokenTtlInMs is num) || refreshToken == null) {
      throw DirectusError(
        message: 'Login response is invalid.',
        code: 1000,
      );
    }
    // accessTokenTtlInMs

    this.refreshToken = refreshToken;
    this.accessToken = accessToken;
    accessTokenTtlInSeconds = (accessTokenTtlInMs / 1000).round();
    accessTokenExpiresAt = DateTime.now().add(
      Duration(seconds: accessTokenTtlInSeconds),
    );
  }
}
