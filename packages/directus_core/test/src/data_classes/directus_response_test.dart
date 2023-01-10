import 'package:dio/dio.dart';
import 'package:directus_core/src/data_classes/data_classes.dart';
import 'package:test/test.dart';

void main() {
  test('that `DirectusResponse.fromDio` works.', () async {
    final response = await DirectusResponse.fromRequest(() async => Response(
          requestOptions: RequestOptions(path: '/'),
          data: {
            'data': {'hello': 'world'}
          },
        ));
    expect(response, isA<DirectusResponse>());
  });

  test('that `DirectusResponse.fromDio` throws on Dio error.', () async {
    expect(() async {
      await DirectusResponse.fromRequest(
        () async => throw DioError(
            requestOptions: RequestOptions(path: '/'),
            response: Response(
              requestOptions: RequestOptions(path: '/'),
              data: 'error',
            )),
      );
    }, throwsA(TypeMatcher<DirectusError>()));
  });
}
