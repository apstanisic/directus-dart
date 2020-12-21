import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/query.dart';
import 'package:directus/src/data_classes/response.dart';
import 'package:directus/src/handlers/items_handler.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mock/mock_dio.dart';

void main() {
  group('ItemsHandler', () {
    late MockDio client;
    late ItemsHandler items;
    setUp(() {
      client = MockDio();
      items = ItemsHandler('test', client: client);
    });

    test('readOne', () async {
      // final items = ItemsHandler('test', client: client);
      when(client.get(any)).thenAnswer(
        (_) async => Response(data: {
          'data': {'id': 'some-id'}
        }),
      );

      final response = await items.readOne('some-id');

      expect(response, isA<DirectusResponse>());
      expect(response.data, {'id': 'some-id'});
      verify(client.get('/items/test/some-id')).called(1);
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

      final response = await items.readMany(query: Query(limit: 5));
      expect(response, isA<DirectusResponse>());
      expect(response.data, [
        {'id': 1},
        {'id': 2}
      ]);

      verify(client.get('/items/test', queryParameters: Query(limit: 5).toMap())).called(1);
    });

    test('createOne', () async {
      final itemData = {'name': 'Test'};
      when(client.post(any, data: anyNamed('data')))
          .thenAnswer((realInvocation) async => Response(data: {'data': itemData}));

      final response = await items.createOne(itemData);
      expect(response, isA<DirectusResponse>());
      expect(response.data, itemData);

      verify(client.post('/items/test', data: itemData)).called(1);
    });

    test('createMany', () async {
      final itemData = {'name': 'Test'};
      when(client.post(any, data: anyNamed('data')))
          .thenAnswer((realInvocation) async => Response(data: {
                'data': [itemData, itemData]
              }));

      final response = await items.createMany([itemData, itemData]);
      expect(response, isA<DirectusResponse>());
      expect(response.data, [itemData, itemData]);

      verify(client.post('/items/test', data: [itemData, itemData])).called(1);
    });

    test('updateOne', () async {
      final itemData = {'name': 'Test'};
      when(client.patch(any, data: anyNamed('data')))
          .thenAnswer((realInvocation) async => Response(data: {'data': itemData}));

      final response = await items.updateOne(data: itemData, id: '5');
      expect(response, isA<DirectusResponse>());
      expect(response.data, itemData);

      verify(client.patch('/items/test/5', data: itemData)).called(1);
    });

    test('updateMany', () async {
      final itemData = {'name': 'Test'};
      when(client.patch(any, data: anyNamed('data'))).thenAnswer(
        (realInvocation) async => Response(data: {
          'data': [itemData, itemData]
        }),
      );

      final response = await items.updateMany(data: itemData, ids: ['1', '2']);
      expect(response, isA<DirectusResponse>());
      expect(response.data, [itemData, itemData]);

      verify(client.patch('/items/test/1,2', data: itemData)).called(1);
    });

    test('deleteOne', () async {
      when(client.patch(any)).thenAnswer((realInvocation) async => Response());

      await items.deleteOne('5');

      verify(client.delete('/items/test/5')).called(1);
    });

    test('deleteMany', () async {
      when(client.patch(any)).thenAnswer((realInvocation) async => Response());

      await items.deleteMany(['1', '2', '3']);

      verify(client.delete('/items/test/1,2,3')).called(1);
    });
  });
}
