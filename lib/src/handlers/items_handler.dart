// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/base_query.dart';
import 'package:directus/src/data_classes/data_classes.dart';

/// Handler for fetching data from Directus API
///
/// Provides CRUD API
class ItemsHandler {
  /// HTTP Client
  Dio client;

  /// Collection endpoint
  /// It's `/items/$collection` for normal collections and `/$collection` for system collection
  final String _endpoint;

  ItemsHandler(String collection, {required this.client})
      : _endpoint = collection.startsWith('directus_')
            ? '/${collection.substring(9)}'
            : '/items/${collection}';

  /// Get item by ID
  ///
  /// [id] is [String] or [int], but Dart does not allow union types.
  /// You can pass optional query that can be to get additional data.
  Future<DirectusResponse<Map>> readOne(String id, {BaseQuery? query}) async {
    return DirectusResponse.fromRequest<Map>(
      () => client.get(
        '$_endpoint/$id',
        queryParameters: query?.toMap(),
      ),
    );
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
    return DirectusResponse.fromRequest(
      () => client.get(
        '$_endpoint',
        queryParameters: query?.toMap(),
      ),
    );
  }

  /// Create one item
  ///
  /// ```dart
  /// await items.createOne({'name': 'Test'});
  /// ```
  Future<DirectusResponse<Map>> createOne(Map data) async {
    return DirectusResponse.fromRequest(() => client.post('$_endpoint', data: data));
  }

  /// Create many items
  ///
  /// ```dart
  /// await items.createMany([{'name': 'Test'}, {'name': 'Test Two'}]);
  /// ```
  Future<DirectusResponse<List<Map>>> createMany(List<Map> data) async {
    return DirectusResponse.fromRequest(() => client.post('$_endpoint', data: data));
  }

  /// Update single item
  ///
  /// ```dart
  /// await items.updateOne(id: '5', data: {'name': 'Test'});
  /// ```
  Future<DirectusResponse<Map>> updateOne({required Map data, required String id}) async {
    return DirectusResponse.fromRequest(() => client.patch('$_endpoint/$id', data: data));
  }

  /// Update many items
  ///
  /// ```dart
  /// await items.updateMany(ids: ['5', '6', '7'], data: {'name': 'Test'});
  /// ```
  Future<DirectusResponse<List<Map>>> updateMany(
      {required List<String> ids, required Map data}) async {
    return DirectusResponse.fromRequest(
      () => client.patch(
        '$_endpoint/${ids.join(',')}',
        data: data,
      ),
    );
  }

  /// Delete item by ID
  ///
  /// ```dart
  /// await items.deleteOne('5');
  /// ```
  Future<void> deleteOne(String id) async {
    try {
      await client.delete('$_endpoint/$id');
    } catch (e) {
      throw DirectusError.fromDio(e);
    }
  }

  /// Delete many items
  ///
  /// ```dart
  /// await items.deleteMany(['1', '2']);
  /// ```
  Future<void> deleteMany(List<String> ids) async {
    try {
      final csvKeys = ids.join(',');
      await client.delete('$_endpoint/$csvKeys');
    } catch (e) {
      throw DirectusError.fromDio(e);
    }
  }
}
