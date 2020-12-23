import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/query.dart';
import 'package:directus/src/data_classes/response.dart';
import 'package:directus/src/handlers/activity_handler.dart';
import 'package:directus/src/handlers/items_handler.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mock/mock_dio.dart';
import '../mock/mock_item_handler.dart';

void main() {
  group('ActivityHandler', () {
    late Dio client;
    late ActivityHandler activity;
    late ItemsHandler handler;

    setUp(() {
      client = MockDio();
      activity = ActivityHandler(client: client);
      handler = MockItemHandler();
    });

    test('handler is set up corectly', () {
      expect(activity.handler, isA<ItemsHandler>());
    });

    test('readOne', () async {
      activity.handler = handler;
      when(handler.readOne('key')).thenAnswer(
        (realInvocation) async => DirectusResponse(Response(data: {'data': {}})),
      );

      final response = await activity.readOne('key');
      expect(response.data, {});
      verify(handler.readOne('key')).called(1);
    });

    test('readMany', () async {
      activity.handler = handler;
      when(handler.readMany(query: anyNamed('query'))).thenAnswer(
        (realInvocation) async => DirectusResponse(Response(data: {
          'data': [{}]
        })),
      );

      final query = Query(limit: 5, offset: 5);

      final response = await activity.readMany(query: query);
      expect(response.data, [{}]);
      verify(handler.readMany(query: query)).called(1);
    });

    test('createComment', () async {
      when(client.post(any, data: anyNamed('data'))).thenAnswer(
        (realInvocation) async => Response(data: {'data': {}}),
      );

      final response = await activity.createComment(collection: 'col', comment: 'comm', item: '5');
      expect(response.data, {});

      verify(client.post('/activity/comments',
          data: {'collection': 'col', 'comment': 'comm', 'item': '5'})).called(1);
    });

    test('updateComment', () async {
      when(client.patch(any, data: anyNamed('data'))).thenAnswer(
        (realInvocation) async => Response(data: {'data': {}}),
      );

      final response = await activity.updateComment('key', {'name': 'test'});
      expect(response.data, {});

      verify(client.patch('/activity/comments/key', data: {'name': 'test'})).called(1);
    });

    test('deleteComment', () async {
      when(client.delete(any)).thenAnswer((realInvocation) async => Response());

      final response = await activity.deleteComment('key');

      verify(client.delete('/activity/comments/key')).called(1);
    });
  });
}
