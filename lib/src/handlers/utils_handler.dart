import 'package:dio/dio.dart';

class UtilsHandler {
  Dio client;

  UtilsHandler({required this.client});

  randomString([int length = 32]) async {
    final response = await client.get('/utils/random/string', queryParameters: {'length': length});
    return response.data;
  }

  generateHash(String str) async {
    final response = await client.post('/utils/hash/generate', data: {'string': str});
    return response.data;
  }

  verifyHash(String str, String hash) async {
    final response = await client.post('/utils/hash/verify', data: {'string': str, 'hash': hash});
    return response.data;
  }

  sort({required String collection, required String itemPk, required String toPk}) async {
    await client.post('/utils/sort/$collection', data: {'item': itemPk, 'to': toPk});
  }

  revert(String revisionPk) async {
    await client.post('/utils/revert/$revisionPk');
  }
}
