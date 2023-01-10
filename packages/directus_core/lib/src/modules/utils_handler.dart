import 'package:dio/dio.dart';
import 'package:directus_core/src/data_classes/data_classes.dart';

class UtilsHandler {
  Dio client;

  UtilsHandler({required this.client});

  Future<String> randomString([int length = 32]) async {
    final response = await DirectusResponse.fromRequest<String>(
      () => client.get(
        'utils/random/string',
        queryParameters: {'length': length},
      ),
    );
    return response.data;
  }

  Future<String> generateHash(String value) async {
    final response = await DirectusResponse.fromRequest<String>(
      () => client.post('utils/hash/generate', data: {'string': value}),
    );

    return response.data;
  }

  Future<bool> verifyHash(String value, String hash) async {
    final response = await DirectusResponse.fromRequest<bool>(
      () => client.post(
        'utils/hash/verify',
        data: {'string': value, 'hash': hash},
      ),
    );
    return response.data;
  }

  Future<void> sort({
    required String collection,
    required String itemPk,
    required String toPk,
  }) async {
    try {
      await client
          .post('utils/sort/$collection', data: {'item': itemPk, 'to': toPk});
    } catch (e) {
      throw DirectusError.fromDio(e);
    }
  }

  Future<void> revert(String revisionPk) async {
    try {
      await client.post('utils/revert/$revisionPk');
    } catch (e) {
      throw DirectusError.fromDio(e);
    }
  }
}
