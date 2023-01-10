import 'package:dio/dio.dart';
import 'package:directus_core/src/data_classes/directus_error.dart';

/// Response that is returned from login or refresh
class AuthResponse {
  /// Refresh token
  late String refreshToken;

  /// Access token
  late String accessToken;

  /// Access token time to live in milliseconds
  ///
  ///
  late int accessTokenTtlMs;

  /// [DateTime] when access token expires.
  ///
  /// It's using time of app time, not server time.
  late DateTime accessTokenExpiresAt;

  /// Static token
  ///
  String? staticToken;

  /// Constructor for manually creating object
  AuthResponse({
    required this.accessToken,
    required this.accessTokenExpiresAt,
    required this.accessTokenTtlMs,
    required this.refreshToken,
    this.staticToken,
  });

  /// Create [AuthResponse] from [Dio] [Response] object.
  AuthResponse.fromResponse(Response response) {
    // Response is possible to be null in testing when we forget to return response.
    // ignore: unnecessary_null_comparison
    if (response == null || response.data == null) {
      throw DirectusError(
          message: 'Response and response data can\'t be null.');
    }

    final data = response.data?['data'];

    if (data == null) throw Exception('Login response is invalid.');

    final accessToken = data['access_token'];
    final refreshToken = data['refresh_token'];
    final accessTokenTtlInMs = data['expires'];

    if (accessToken == null ||
        accessTokenTtlInMs is! int ||
        refreshToken == null) {
      throw DirectusError(message: 'Login response is invalid.');
    }

    this.refreshToken = refreshToken;
    this.accessToken = accessToken;
    accessTokenTtlMs = accessTokenTtlInMs;
    accessTokenExpiresAt = DateTime.now().add(
      Duration(milliseconds: accessTokenTtlMs),
    );
  }
}
