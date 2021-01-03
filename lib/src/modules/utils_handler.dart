// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/data_classes.dart';

class UtilsHandler {
  Dio client;

  UtilsHandler({required this.client});

  Future<String> randomString([int length = 32]) async {
    try {
      final response = await client.get(
        'utils/random/string',
        queryParameters: {'length': length},
      );
      return DirectusResponse(response).data;
    } catch (e) {
      throw DirectusError.fromDio(e);
    }
  }

  Future<String> generateHash(String value) async {
    try {
      final response = await client.post('utils/hash/generate', data: {'string': value});
      return DirectusResponse(response).data;
    } catch (e) {
      throw DirectusError.fromDio(e);
    }
  }

  Future<bool> verifyHash(String value, String hash) async {
    try {
      final response = await client.post(
        'utils/hash/verify',
        data: {'string': value, 'hash': hash},
      );
      return DirectusResponse(response).data;
    } catch (e) {
      throw DirectusError.fromDio(e);
    }
  }

  Future<void> sort({
    required String collection,
    required String itemPk,
    required String toPk,
  }) async {
    try {
      await client.post('utils/sort/$collection', data: {'item': itemPk, 'to': toPk});
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
