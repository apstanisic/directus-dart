// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';

/// Error that SDK throws when API request returns 400+ status code.
///
///
class DirectusError implements Exception {
  /// Directus message.
  String message;

  /// HTTP message.
  String? codeMessage;

  /// HTTP code. If there is non HTTP error [code] will be 1000
  int code;

  DirectusError({required this.message, required this.code, required this.codeMessage});

  factory DirectusError.fromDio(dynamic error) {
    if (!(error is DioError)) {
      return DirectusError(
        message: 'Error should come from Dio.',
        code: 500,
        codeMessage: 'Internal server error',
      );
    }
    // final Map<String, List<Map<String, dynamic>?>?>? apiErrors = error.response.data;
    var errorMessage;
    try {
      final apiErrors = Map.from(error.response.data);
      errorMessage = apiErrors['errors']?[0]?['message'] ?? 'Problem with Directus.';
    } catch (e) {
      errorMessage = 'Problem with Directus.';
    }

    return DirectusError(
      message: errorMessage.toString(),
      code: error.response.statusCode,
      codeMessage: error.response.statusMessage,
    );
  }
}
