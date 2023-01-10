import 'package:dio/dio.dart';
import 'package:directus_core/src/data_classes/data_classes.dart';
import 'package:directus_core/src/modules/items/items_handler.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/mock_dio_response.dart';
import '../../mock/mocks.mocks.dart';

void main() {
  group('ItemsHandler', () {
    /// Placeholder data
    late Map<String, dynamic> exampleItem;
    late MockDio client;
    late ItemsHandler items;

    setUp(() {
      client = MockDio();
      items = ItemsHandler('test', client: client);
      exampleItem = {'id': 1, 'name': 'Test'};
    });

    test('readOne works properly', () async {
      when(client.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer(dioResponse({'data': exampleItem}));

      final response = await items.readOne('some-id', query: OneQuery());

      expect(response, isA<DirectusResponse>());
      expect(response.data, exampleItem);
      verify(client.get('items/test/some-id',
              queryParameters: OneQuery().toMap()))
          .called(1);
    });

    test('readMany works properly', () async {
      when(client.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer(dioResponse({
        'data': [exampleItem, exampleItem]
      }));

      final query = Query(limit: 5);
      final response = await items.readMany(query: query);

      expect(response, isA<DirectusListResponse>());
      expect(response.data, [exampleItem, exampleItem]);
      verify(client.get('items/test', queryParameters: query.toMap()))
          .called(1);
    });

// Regression test: https://github.com/apstanisic/directus-dart/issues/18
    test('readMany applies filter without query', () async {
      when(client.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer(dioResponse({
        'data': [exampleItem, exampleItem]
      }));

      final response =
          await items.readMany(filters: Filters({'one': Filter.eq(2)}));

      final query = Query();
      expect(response, isA<DirectusListResponse>());
      expect(response.data, [exampleItem, exampleItem]);
      verify(client.get('items/test',
          queryParameters:
              query.toMap(filters: Filters({'one': Filter.eq(2)})))).called(1);
    });

    test('createOne works properly', () async {
      when(client.post(any, data: anyNamed('data')))
          .thenAnswer(dioResponse({'data': exampleItem}));

      final response = await items.createOne(exampleItem);

      expect(response, isA<DirectusResponse>());
      expect(response.data, exampleItem);
      verify(client.post('items/test', data: exampleItem)).called(1);
    });

    test('createMany works properly', () async {
      when(client.post(any, data: anyNamed('data'))).thenAnswer(dioResponse({
        'data': [exampleItem, exampleItem]
      }));

      final response = await items.createMany([exampleItem, exampleItem]);

      expect(response, isA<DirectusListResponse>());
      expect(response.data, [exampleItem, exampleItem]);
      verify(client.post('items/test', data: [exampleItem, exampleItem]))
          .called(1);
    });

    test('updateOne works properly', () async {
      when(client.patch(any, data: anyNamed('data')))
          .thenAnswer(dioResponse({'data': exampleItem}));

      final response = await items.updateOne(data: exampleItem, id: '5');

      expect(response, isA<DirectusResponse>());
      expect(response.data, exampleItem);
      verify(client.patch('items/test/5', data: exampleItem)).called(1);
    });

    test('updateMany works properly', () async {
      when(client.patch(any, data: anyNamed('data'))).thenAnswer(dioResponse({
        'data': [exampleItem, exampleItem]
      }));

      final response =
          await items.updateMany(data: exampleItem, ids: ['1', '2']);

      expect(response, isA<DirectusListResponse>());
      expect(response.data, [exampleItem, exampleItem]);
      verify(client.patch('items/test', data: {
        "data": exampleItem,
        "keys": ['1', '2']
      })).called(1);
    });

    test('deleteOne works properly', () async {
      when(client.delete(any)).thenAnswer(dioResponse());
      await items.deleteOne('5');
      verify(client.delete('items/test/5')).called(1);
    });

    test('deleteMany works properly', () async {
      when(client.delete(any)).thenAnswer(dioResponse());
      await items.deleteMany(['1', '2', '3']);
      verify(client.delete('items/test/1,2,3')).called(1);
    });

    test('deleteOne throws DirectusError, and not DioError', () async {
      when(client.delete(any)).thenThrow(DioError);
      expect(() => items.deleteOne('5'), throwsException);
      verify(client.delete('items/test/5')).called(1);
    });

    test('deleteMany throws DirectusError, and not DioError', () async {
      when(client.delete(any)).thenThrow(DioError);
      expect(() => items.deleteMany(['1', '2', '3']), throwsException);
      verify(client.delete('items/test/1,2,3')).called(1);
    });
  });
}
