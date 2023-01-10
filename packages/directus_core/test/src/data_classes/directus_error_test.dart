import 'package:dio/dio.dart';
import 'package:directus_core/src/data_classes/directus_error.dart';
import 'package:test/test.dart';

void main() {
  test(
      'that DirectusError will use generic error if `fromDio` is not `DioError`.',
      () async {
    final error = DirectusError.fromDio(Exception());
    expect(error.code, 1000);
    expect(error.message, 'Error should come from Dio.');
  });

  test(
      'that DirectusError will parse DioError to get correct error from server API.',
      () async {
    final error = DirectusError.fromDio(DioError(
        requestOptions: RequestOptions(path: '/'),
        response: Response(
          requestOptions: RequestOptions(path: '/'),
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
  });

  test('that DirectusError will keep the original DioError', () {
    final dioError = DioError(
      requestOptions: RequestOptions(path: '/'),
      response: Response(
        requestOptions: RequestOptions(path: '/'),
        data: {
          'errors': [
            {'message': 'API message'}
          ]
        },
        statusCode: 400,
        statusMessage: 'Bad Request',
      ),
    );
    final error = DirectusError.fromDio(dioError);

    expect(error.dioError, dioError);
  });
}
