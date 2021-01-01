// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';

/// Error that SDK throws when API request returns 400+ status code.
///
///
class DirectusError implements Exception {
  /// Message explaining error.
  late final String message;

  /// HTTP code. If there is non HTTP error (not problem with an API) [code] will be 1000.
  late final int code;

  /// Additional info that can be provided to error.
  late final Map<String, dynamic>? additionalInfo;

  DirectusError({
    required this.message,
    required this.code,
    this.additionalInfo,
  });

  /// Convert [DioError] to [DirectusError].
  DirectusError.fromDio(dynamic error) {
    // assert(error is DioError, 'This should only be called when Dio throws an error.');

    if (!(error is DioError)) {
      message = 'Error should come from Dio.';
      code = 1000;
      return;
    }

    var errorMessage;

    try {
      final apiErrors = Map.from(error.response.data);
      errorMessage = apiErrors['errors']?[0]?['message'] ?? 'Problem with Directus.';
    } catch (e) {
      errorMessage = 'Problem with Directus.';
    }

    message = errorMessage.toString();
    code = error.response.statusCode;
    additionalInfo = {'codeMessage': error.response.statusMessage, 'response': error.response};
  }
}
