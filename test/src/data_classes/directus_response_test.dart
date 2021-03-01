import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/data_classes.dart';
import 'package:test/test.dart';

void main() {
  test('that `DirectusResponse.fromDio` works.', () async {
    final response = await DirectusResponse.fromRequest(() async => Response(
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
            response: Response(
          data: 'error',
        )),
      );
    }, throwsA(TypeMatcher<DirectusError>()));
  });
}
