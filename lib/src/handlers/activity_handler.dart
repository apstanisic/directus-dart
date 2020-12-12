import 'package:dio/dio.dart';
import 'package:directus/src/handlers/items_handler.dart';
import 'package:directus/src/query.dart';

class ActivityHandler {
  late Dio client;
  late ItemsHandler handler;

  ActivityHandler({required this.client, required}) {
    handler = ItemsHandler('directus_activity', client: client);
  }

  readOne(String key) async {
    return await handler.readOne(key);
  }

  readMany({Query? query}) async {
    return await handler.readMany(query: query);
  }

  createComment({required String collection, required String item, required String comment}) async {
    final response = await client.post(
      '/activity/comments',
      data: {'collection': collection, 'item': item, 'comment': comment},
    );
    return response.data;
  }

  updateComment(String key, Map data) async {
    final response = await client.patch('/activity/comments/$key', data: data);
    return response.data;
  }

  Future<void> deleteComment(String key) async {
    await client.delete('/activity/comments/$key');
  }
}
