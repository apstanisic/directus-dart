import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/data_classes.dart';
import 'package:test/test.dart';

void main() {
  test('DirectusListResponse.fromDio works', () async {
    final response = await DirectusListResponse.fromRequest(() async => Response(
          data: {
            'data': [
              {'hello': 'world'}
            ]
          },
        ));
    expect(response, isA<DirectusListResponse>());
  });

  test('DirectusListResponse.fromDio throws on Dio error', () async {
    expect(() async {
      await DirectusListResponse.fromRequest(
        () async => throw DioError(
            response: Response(
          data: 'error',
        )),
      );
    }, throwsA(TypeMatcher<DirectusError>()));
  });

  test('Meta is properly set', () async {
    final response = await DirectusListResponse.fromRequest(
      () async => Response(data: {
        'data': [],
        'meta': {'total_count': 2, 'filter_count': 1}
      }),
    );
    expect(response.meta?.filterCount, 1);
    expect(response.meta?.totalCount, 2);
  });
}
