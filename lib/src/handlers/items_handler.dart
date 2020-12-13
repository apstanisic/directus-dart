import 'package:dio/dio.dart';
import 'package:directus/src/query/query.dart';

class ItemsHandler {
  Dio client;
  late String _endpoint;

  ItemsHandler(String collection, {required this.client}) {
    _endpoint =
        collection.startsWith('directus_') ? '/${collection.substring(9)}' : '/items/${collection}';
  }

  Future<Response<dynamic>> readOne(String id) async {
    final response = await client.get('$_endpoint/$id');
    return response;
  }

  Future<Response<dynamic>> readMany({Query? query}) async {
    final response = await client.get('$_endpoint', queryParameters: query?.toMap());
    return response;
  }

  Future<Response<dynamic>> create(Map data) async {
    final response = await client.post('$_endpoint', data: data);
    return response;
  }

  Future<Response<dynamic>> createMany(List<Map> data) async {
    final response = await client.post('$_endpoint', data: data);
    return response;
  }

  Future<Response<dynamic>> updateOne({required Map data, required String id}) async {
    final response = await client.patch('$_endpoint/$id', data: data);
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

  Future<Response<dynamic>> deleteOne(String id) async {
    final response = await client.delete('$_endpoint/$id');
    return response;
  }

  Future<Response<dynamic>> deleteMany(List<String> ids) async {
    final csvKeys = ids.join(',');
    final response = await client.delete('$_endpoint/$csvKeys');
    return response;
  }
}
