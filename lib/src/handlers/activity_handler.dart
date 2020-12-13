import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/query.dart';
import 'package:directus/src/handlers/items_handler.dart';

class ActivityHandler {
  Dio client;
  ItemsHandler handler;

  ActivityHandler({required this.client})
      : handler = ItemsHandler('directus_activity', client: client);

  readOne(String key) async {
    return await handler.readOne(key);
  }

  readMany({Query? query}) async {
    return await handler.readMany(query: query);
  }

  /// Create comment
  createComment({required String collection, required String item, required String comment}) async {
    final response = await client.post(
      '/activity/comments',
      data: {'collection': collection, 'item': item, 'comment': comment},
    );
    return response.data;
  }

  /// Update existing comment
  updateComment(String key, Map data) async {
    final response = await client.patch('/activity/comments/$key', data: data);
    return response.data;
  }

  /// Delete comment
  Future<void> deleteComment(String key) async {
    await client.delete('/activity/comments/$key');
  }
}
