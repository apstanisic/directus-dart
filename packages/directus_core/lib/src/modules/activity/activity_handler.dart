import 'package:dio/dio.dart';
import 'package:directus_core/src/data_classes/data_classes.dart';
import 'package:directus_core/src/modules/activity/directus_activity.dart';
import 'package:directus_core/src/modules/items/items_handler.dart';

import 'activity_converter.dart';

class ActivityHandler {
  Dio client;
  ItemsHandler<DirectusActivity> handler;

  ActivityHandler({required this.client})
      : handler = ItemsHandler(
          'directus_activity',
          client: client,
          converter: ActivityConverter(),
        );

  /// Same method as [ItemsHandler.readOne]
  late final readOne = handler.readOne;

  /// Same method as [ItemsHandler.readMany]
  late final readMany = handler.readMany;

  /// Create comment
  Future<DirectusResponse<Map>> createComment({
    required String collection,
    required String itemId,
    required String comment,
  }) async {
    return DirectusResponse.fromRequest(
      () => client.post(
        'activity/comments',
        data: {'collection': collection, 'item': itemId, 'comment': comment},
      ),
    );
  }

  /// Update existing comment
  Future<DirectusResponse<Map>> updateComment({
    required String id,
    required String comment,
  }) async {
    return DirectusResponse.fromRequest(
      () => client.patch(
        'activity/comments/$id',
        data: {'comment': comment},
      ),
    );
  }

  /// Delete comment
  Future<void> deleteComment(String key) async {
    try {
      await client.delete('activity/comments/$key');
    } catch (e) {
      throw DirectusError.fromDio(e);
    }
  }
}
