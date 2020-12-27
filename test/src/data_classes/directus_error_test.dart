// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/directus_error.dart';
import 'package:test/test.dart';

void main() {
  test('that DirectusError will use generic error if `fromDio` is not `DioError`.', () async {
    final error = DirectusError.fromDio(Exception());
    expect(error.code, 500);
    expect(error.message, 'Error should come from Dio.');
    expect(error.codeMessage, 'Internal server error');
  });

  test('that DirectusError will parse DioError to get correct error from server API.', () async {
    final error = DirectusError.fromDio(DioError(
        response: Response(
      data: {
        'errors': [
          {'message': 'API message'}
        ]
      },
      statusCode: 400,
      statusMessage: 'Bad Request',
    )));

    expect(error.code, 400);
    expect(error.message, 'API message');
    expect(error.codeMessage, 'Bad Request');
  });
}
