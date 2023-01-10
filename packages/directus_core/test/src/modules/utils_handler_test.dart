import 'package:directus_core/src/modules/utils_handler.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mock/mock_dio_response.dart';
import '../mock/mocks.mocks.dart';

void main() {
  group('UtilsHandler', () {
    late UtilsHandler utils;
    late MockDio client;

    setUp(() {
      client = MockDio();
      utils = UtilsHandler(client: client);
    });

    test('that `randomString` works.', () async {
      when(client.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer(dioResponse({'data': 'some-string'}));

      final response = await utils.randomString();

      expect(response, isA<String>());
      verify(client.get('utils/random/string', queryParameters: {'length': 32}))
          .called(1);
    });

    test('that user can change `randomString` length.', () async {
      when(client.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer(dioResponse({'data': 'some-string'}));

      final response = await utils.randomString(5);

      expect(response, isA<String>());
      verify(
        client.get('utils/random/string', queryParameters: {'length': 5}),
      ).called(1);
    });

    test('that `generateHash` works.', () async {
      when(client.post(any, data: anyNamed('data')))
          .thenAnswer(dioResponse({'data': 'some-hash'}));

      var response = await utils.generateHash('some-string');

      expect(response, 'some-hash');
      verify(client.post(
        'utils/hash/generate',
        data: {'string': 'some-string'},
      )).called(1);
    });

    test('that `verifyHash` works.', () async {
      when(client.post(any, data: anyNamed('data')))
          .thenAnswer(dioResponse({'data': true}));

      var response = await utils.verifyHash('some-string', 'hash-string');

      expect(response, true);
      verify(client.post(
        'utils/hash/verify',
        data: {'string': 'some-string', 'hash': 'hash-string'},
      )).called(1);
    });

    test('that `sort` works.', () async {
      when(client.post(any, data: anyNamed('data'))).thenAnswer(dioResponse());

      await utils.sort(collection: 'test_collection', itemPk: '1', toPk: '2');

      verify(client.post(
        'utils/sort/test_collection',
        data: {'item': '1', 'to': '2'},
      )).called(1);
    });

    test('that `revert` works', () async {
      when(client.post(any)).thenAnswer(dioResponse());

      await utils.revert('1');

      verify(client.post('utils/revert/1')).called(1);
    });
  });
}
