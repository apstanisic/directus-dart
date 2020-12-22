import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/data_classes.dart';
import 'package:directus/src/data_classes/directus_item.dart';

/// Handler for fetching data from Directus API
/// Provides CRUD API
class ItemsHandler {
  /// HTTP Client
  Dio client;

  /// Collection endpoint
  /// It's `/items/$collection` for normal collections and `/$collection` for system collection
  final String _endpoint;

  ItemsHandler(String collection, {required this.client, DirectusItem? convert})
      : _endpoint = collection.startsWith('directus_')
            ? '/${collection.substring(9)}'
            : '/items/${collection}';

  /// Get item by ID
  ///
  /// [id] is [String] or [int], but Dart does not allow union types
  Future<DirectusResponse<Map>> readOne(String id) async {
    final response = await client.get('$_endpoint/$id');
    return DirectusResponse<Map>(response);
  }

  /// Get many items
  ///
  /// ```dart
  /// await this.readMany();
  ///
  /// await this.readMany(query: Query(
  ///   limit: 5,
  ///   filter: {
  ///     'name': Filter.eq('Test')
  ///   }
  /// ));
  /// ```
  Future<DirectusResponse<List<Map>>> readMany({Query? query}) async {
    final response = await client.get(
      '$_endpoint',
      queryParameters: query?.toMap(),
    );
    return DirectusResponse<List<Map>>(response);
  }

  /// Create one item
  ///
  /// ```dart
  /// await items.createOne({'name': 'Test'});
  /// ```
  Future<DirectusResponse<Map>> createOne(Map data) async {
    final response = await client.post('$_endpoint', data: data);
    return DirectusResponse<Map>(response);
  }

  /// Create many items
  ///
  /// ```dart
  /// await items.createMany([{'name': 'Test'}, {'name': 'Test Two'}]);
  /// ```
  Future<DirectusResponse<List<Map>>> createMany(List<Map> data) async {
    final response = await client.post('$_endpoint', data: data);
    return DirectusResponse<List<Map>>(response);
  }

  /// Update single item
  ///
  /// ```dart
  /// await items.updateOne(id: '5', data: {'name': 'Test'});
  /// ```
  Future<DirectusResponse<Map>> updateOne({required Map data, required String id}) async {
    final response = await client.patch('$_endpoint/$id', data: data);
    return DirectusResponse<Map>(response);
  }

  /// Update many items
  ///
  /// ```dart
  /// await items.updateMany(ids: ['5', '6', '7'], data: {'name': 'Test'});
  /// ```
  Future<DirectusResponse<List<Map>>> updateMany(
      {required List<String> ids, required Map data}) async {
    final response = await client.patch(
      '$_endpoint/${ids.join(',')}',
      data: data,
    );
    return DirectusResponse<List<Map>>(response);
  }

  /// Delete item by ID
  ///
  /// ```dart
  /// await items.deleteOne('5');
  /// ```
  Future<void> deleteOne(String id) async {
    await client.delete('$_endpoint/$id');
  }

  /// Delete many items
  ///
  /// ```dart
  /// await items.deleteMany(['1', '2']);
  /// ```
  Future<void> deleteMany(List<String> ids) async {
    final csvKeys = ids.join(',');
    await client.delete('$_endpoint/$csvKeys');
  }
}
