import 'package:directus_core/src/data_classes/directus_list_response.dart';
import 'package:directus_core/src/data_classes/directus_response.dart';
import 'package:directus_core/src/data_classes/query.dart';
import 'package:directus_core/src/modules/activity/activity_handler.dart';
import 'package:directus_core/src/modules/activity/directus_activity.dart';
import 'package:directus_core/src/modules/items/items_handler.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mock/mock_dio_response.dart';
import '../../mock/mocks.mocks.dart';

void main() {
  group('ActivityHandler', () {
    late MockDio client;
    late ActivityHandler activity;
    late MockItemsHandler<DirectusActivity> handler;

    setUp(() {
      client = MockDio();
      activity = ActivityHandler(client: client);
      handler = MockItemsHandler<DirectusActivity>();
    });

    test('handler is set up corectly', () {
      expect(activity.handler, isA<ItemsHandler>());
    });

    test('that `readOne` works.', () async {
      activity.handler = handler;
      when(handler.readOne(any)).thenAnswer((realInvocation) async =>
          DirectusResponse.manually(DirectusActivity()));

      final response = await activity.readOne('key');

      expect(response.data, isA<DirectusActivity>());
      verify(handler.readOne('key')).called(1);
    });

    test('that `readMany` works.', () async {
      activity.handler = handler;
      final activityItem = DirectusActivity();
      when(handler.readMany(query: anyNamed('query'))).thenAnswer(
          (realInvocation) async =>
              DirectusListResponse.manually([activityItem]));

      final query = Query(limit: 5, offset: 5);
      final response = await activity.readMany(query: query);

      expect(response.data, [activityItem]);
      verify(handler.readMany(query: query)).called(1);
    });

    test('that `createComment` works', () async {
      when(client.post(any, data: anyNamed('data'))).thenAnswer(dioResponse({
        'data': {'id': 5}
      }));

      final response = await activity.createComment(
        collection: 'col',
        comment: 'comm',
        itemId: '5',
      );

      expect(response.data, {'id': 5});
      verify(client.post('activity/comments',
              data: {'collection': 'col', 'comment': 'comm', 'item': '5'}))
          .called(1);
    });

    test('that `updateComment` works.', () async {
      when(client.patch(any, data: anyNamed('data'))).thenAnswer(dioResponse({
        'data': {'hello': 'world'}
      }));

      final response =
          await activity.updateComment(id: 'key', comment: 'newComment');
      expect(response.data, {'hello': 'world'});

      verify(client.patch('activity/comments/key',
          data: {'comment': 'newComment'})).called(1);
    });

    test('that `deleteComment` works.', () async {
      when(client.delete(any)).thenAnswer(dioResponse());

      await activity.deleteComment('some-id');

      verify(client.delete('activity/comments/some-id')).called(1);
    });
  });
}
