import 'package:dio/dio.dart';

/// Error that any exception inside SDK will throw.
///
/// SDK should always throw [DirectusError], and never [Exception] or [DioError].
/// If error is from an API (it returns status code > 400), that code will be set
/// as [code]. Otherwise [code] will be set to 1000. Error 1000 is used for when user didn't
/// properly configure SDK, or there is internal error.
class DirectusError implements Exception {
  /// Message explaining error.
  late final String message;

  /// Error code.
  ///
  /// If there is an error in HTTP request, [code] will be status code from response.
  /// Otherwise, code will be 1000.
  late final int code;

  /// Additional info that can be provided to error.
  late final Map<String, Object?>? additionalInfo;

  /// Original DioError from error.
  late final DioError? dioError;

  /// Constructor
  DirectusError({
    required this.message,
    int? code,
    this.additionalInfo,
  }) : code = code ?? 1000;

  /// Convert [DioError] to [DirectusError].
  ///
  /// It accepts [error] as [dynamic] for because by default exception is of type [Object],
  /// and it's a lot less boilerplate that for every error to both catch for [DioError],
  /// and for any other error. This way, in case error is not [DioError], it will simply
  /// complain that error is invalid.
  ///
  DirectusError.fromDio(Object error) {
    if (error is! DioError) {
      message = 'Error should come from Dio.';
      code = 1000;
      additionalInfo = {'originalError': error};
      return;
    }

    try {
      final apiErrors = Map.from(error.response?.data);
      // This is path to first error
      final errorMessage =
          apiErrors['errors']?[0]?['message'] ?? 'Problem with Directus.';
      message = errorMessage.toString();
    } catch (e) {
      message = 'Problem with Directus.';
    }

    code = error.response?.statusCode ?? 1000;
    additionalInfo = {
      'codeMessage': error.response?.statusMessage ?? 'Error',
      'response': error.response
    };
    dioError = error;
  }
}
