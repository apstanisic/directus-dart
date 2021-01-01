// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/one_query.dart';
import 'package:directus/src/data_classes/query.dart';
import 'package:directus/src/data_classes/directus_response.dart';
import 'package:directus/src/modules/items/items_handler.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/mock_dio.dart';

void main() {
  group('ItemsHandler', () {
    late MockDio client;
    late ItemsHandler items;

    setUp(() {
      client = MockDio();
      items = ItemsHandler('test', client: client);
    });

    test('that `readOne` works.', () async {
      when(client.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => Response(data: {
                'data': {'id': 'some-id'}
              }));

      final response = await items.readOne('some-id', query: OneQuery());

      expect(response, isA<DirectusResponse>());
      expect(response.data, {'id': 'some-id'});
      verify(client.get('/items/test/some-id', queryParameters: OneQuery().toMap())).called(1);
    });

    test('readMany', () async {
      when(client.get(any, queryParameters: anyNamed('queryParameters'))).thenAnswer(
        (realInvocation) async => Response(data: {
          'data': [
            {'id': 1},
            {'id': 2}
          ]
        }),
      );

      final query = Query(limit: 5);
      final response = await items.readMany(query: query);

      expect(response, isA<DirectusListResponse>());
      expect(response.data, [
        {'id': 1},
        {'id': 2}
      ]);
      verify(client.get('/items/test', queryParameters: query.toMap())).called(1);
    });

    test('that `createOne` works.', () async {
      final itemData = {'name': 'Test'};
      when(client.post(any, data: anyNamed('data')))
          .thenAnswer((realInvocation) async => Response(data: {'data': itemData}));

      final response = await items.createOne(itemData);

      expect(response, isA<DirectusResponse>());
      expect(response.data, itemData);
      verify(client.post('/items/test', data: itemData)).called(1);
    });

    test('that `createMany` works.', () async {
      final itemData = {'name': 'Test'};
      when(client.post(any, data: anyNamed('data'))).thenAnswer(
        (realInvocation) async => Response(data: {
          'data': [itemData, itemData]
        }),
      );

      final response = await items.createMany([itemData, itemData]);

      expect(response, isA<DirectusListResponse>());
      expect(response.data, [itemData, itemData]);
      verify(client.post('/items/test', data: [itemData, itemData])).called(1);
    });

    test('that `updateOne` works.', () async {
      final itemData = {'name': 'Test'};
      when(client.patch(any, data: anyNamed('data')))
          .thenAnswer((realInvocation) async => Response(data: {'data': itemData}));

      final response = await items.updateOne(data: itemData, id: '5');

      expect(response, isA<DirectusResponse>());
      expect(response.data, itemData);
      verify(client.patch('/items/test/5', data: itemData)).called(1);
    });

    test('that `updateMany` works.', () async {
      final itemData = {'name': 'Test'};
      when(client.patch(any, data: anyNamed('data'))).thenAnswer(
        (realInvocation) async => Response(data: {
          'data': [itemData, itemData]
        }),
      );

      final response = await items.updateMany(data: itemData, ids: ['1', '2']);

      expect(response, isA<DirectusListResponse>());
      expect(response.data, [itemData, itemData]);
      verify(client.patch('/items/test/1,2', data: itemData)).called(1);
    });

    test('that `deleteOne` works.', () async {
      when(client.delete(any)).thenAnswer((realInvocation) async => Response());

      await items.deleteOne('5');

      verify(client.delete('/items/test/5')).called(1);
    });

    test('that `deleteMany` works.', () async {
      when(client.delete(any)).thenAnswer((realInvocation) async => Response());

      await items.deleteMany(['1', '2', '3']);

      verify(client.delete('/items/test/1,2,3')).called(1);
    });

    test('that `deleteOne` throws `DirectusError`.', () async {
      when(client.delete(any)).thenThrow(DioError);

      expect(() => items.deleteOne('5'), throwsException);

      verify(client.delete('/items/test/5')).called(1);
    });

    test('that `deleteMany` works.', () async {
      when(client.delete(any)).thenThrow(DioError);

      expect(() => items.deleteMany(['1', '2', '3']), throwsException);

      verify(client.delete('/items/test/1,2,3')).called(1);
    });
  });
}
