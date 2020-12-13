import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/data_classes.dart';

/// Handler for fetching data from Directus API
/// Provides CRUD API
class ItemsHandler<D> {
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
  Future<T> readOne<T extends D>(String id) async {
    final response = await client.get<DirectusResponse<T>>('$_endpoint/$id');
    return response.data.data;
  }

  /// Get many items
  /// ```dart
  /// await this.readMany(query: Query(
  ///   filter: Filters([
  ///     Filter('a', 'b')
  ///   ])
  /// ));
  /// ```
  Future<List<T>> readMany<T extends D>({Query? query}) async {
    final response = await client.get<DirectusResponse<List<T>>>(
      '$_endpoint',
      queryParameters: query?.toMap(),
    );
    return response.data.data;
  }

  /// Create one item
  Future<T> createOne<T extends D>(Map data) async {
    final response = await client.post<DirectusResponse<T>>('$_endpoint', data: data);
    return response.data.data;
  }

  /// Update single item
  Future<T> updateOne<T extends D>({required Map data, required String id}) async {
    final response = await client.patch<DirectusResponse<T>>('$_endpoint/$id', data: data);
    return response.data.data;
  }

  /// Update many items
  Future<List<T>> updateMany<T extends D>({required List<String> ids, required Map data}) async {
    final response = await client.patch<DirectusResponse<List<T>>>(
      '$_endpoint/${ids.join(',')}',
      data: data,
    );
    return response.data.data;
  }

  /// Delete item by ID
  Future<void> deleteOne(String id) async {
    final response = await client.delete('$_endpoint/$id');
    return response.data;
  }

  /// Delete many items
  Future<void> deleteMany(List<String> ids) async {
    final csvKeys = ids.join(',');
    await client.delete('$_endpoint/$csvKeys');
  }
}
