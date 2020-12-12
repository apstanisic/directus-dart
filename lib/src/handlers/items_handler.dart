// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/query.dart';

class ItemsHandler {
  late Dio client;
  late String _endpoint;

  ItemsHandler(String collection, {Dio? client}) {
    this.client = client ?? Dio();
    _endpoint =
        collection.startsWith('directus_') ? '/${collection.substring(9)}' : '/items/${collection}';
  }

  Future<Response<dynamic>> readOne(String key) async {
    final response = await client.get('$_endpoint/$key');
    return response;
  }

  Future<Response<dynamic>> readMany({Query? query}) async {
    final response = await client.get('$_endpoint', queryParameters: query?.toMap());
    return response;
  }

  Future<Response<dynamic>> create({required Map data}) async {
    final response = await client.post('$_endpoint', data: data);
    return response;
  }

  Future<Response<dynamic>> createMany({required List<Map> data}) async {
    final response = await client.post('$_endpoint', data: data);
    return response;
  }

  Future<Response<dynamic>> updateOne({required Map data, required String key}) async {
    final response = await client.patch('$_endpoint/$key', data: data);
    return response;
  }

  Future<Response<dynamic>> updateMany({required Query query, required Map data}) async {
    final response = await client.patch(
      '$_endpoint',
      data: data,
      queryParameters: query.toMap(),
    );
    return response;
  }

  Future<Response<dynamic>> deleteOne(String key) async {
    final response = await client.delete('$_endpoint/$key');
    return response;
  }

  Future<Response<dynamic>> deleteMany(List<String> keys) async {
    final csvKeys = keys.join(',');
    final response = await client.delete('$_endpoint/$csvKeys');
    return response;
  }
}
