// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';

/// Error that any exception inside SDK will throw.
///
/// SDK should always throw [DirectusError], and never [Exception] or [DioError].
/// If error is from an API (it returns statuc code > 400), that code will be set
/// as [code]. Othervise [code] will be set to 1000. That is used for when user didn't
/// properly configure SDK, or there is internal error.
class DirectusError implements Exception {
  /// Message explaining error.
  late final String message;

  /// Error code.
  ///
  /// If there is an error in HTTP request, [code] will be status code from response.
  /// Othervise, code will be 1000.
  late final int code;

  /// Additional info that can be provided to error.
  late final Map<String, dynamic>? additionalInfo;

  /// Constructor
  DirectusError({
    required this.message,
    required this.code,
    this.additionalInfo,
  });

  /// Convert [DioError] to [DirectusError].
  ///
  /// It accepts [error] as [dynamic] for because by default exception is of type [Object],
  /// and it's a lot less boilerplate that for every error to both catch for [DioError],
  /// and for any other error. This way, in case error is not [DioErro], it will simply
  /// complain that error is invalid.
  ///
  DirectusError.fromDio(dynamic error) {
    if (!(error is DioError)) {
      message = 'Error should come from Dio.';
      code = 1000;
      additionalInfo = {'originalError': error};
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
