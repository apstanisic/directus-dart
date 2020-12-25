import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/response.dart';

class UtilsHandler {
  Dio client;

  UtilsHandler({required this.client});

  Future<String> randomString([int length = 32]) async {
    final response = await client
        .get('/utils/random/string', queryParameters: {'length': length});
    return DirectusResponse(response).data;
  }

  Future<String> generateHash(String value) async {
    final response =
        await client.post('/utils/hash/generate', data: {'string': value});
    return DirectusResponse(response).data;
  }

  Future<bool> verifyHash(String value, String hash) async {
    final response = await client
        .post('/utils/hash/verify', data: {'string': value, 'hash': hash});
    return DirectusResponse(response).data;
  }

  Future<void> sort({
    required String collection,
    required String itemPk,
    required String toPk,
  }) async {
    await client
        .post('/utils/sort/$collection', data: {'item': itemPk, 'to': toPk});
  }

  Future<void> revert(String revisionPk) async {
    await client.post('/utils/revert/$revisionPk');
  }
}
