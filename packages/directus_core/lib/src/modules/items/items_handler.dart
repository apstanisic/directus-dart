import 'package:dio/dio.dart';
import 'package:directus_core/src/data_classes/data_classes.dart';
import 'package:meta/meta.dart';

import 'items_converter.dart';
import 'map_items_converter.dart';

/// Handler for fetching data from Directus API
///
/// Provides CRUD API.
/// [id] in most of the methods is accepting [String] instead of [dynamic] or [int].
/// This provided better type safety, and in the end [id] is always converted to
/// [String] anyway. So this way we have better type safety, it's only a little bit more
/// verbose because user has to call [toString] when [id] is number.
class ItemsHandler<T> {
  /// HTTP Client
  @protected
  Dio client;

  /// Used to convert object from and to [Map].
  ItemsConverter converter;

  /// Collection endpoint
  /// It's `/items/$collection` for normal collections and `/$collection` for system collection
  final String _endpoint;

  ItemsHandler(String collection,
      {required this.client, ItemsConverter? converter})
      : converter = converter ?? MapItemsConverter(),
        _endpoint = collection.startsWith('directus_')
            ? collection.substring(9)
            : 'items/$collection';

  /// Get item by ID
  ///
  /// [id] is [String] or [int], but Dart does not allow union types.
  /// You can pass optional query that can be to get additional data.
  /// You can pass optional [OneQuery] for specifying response.
  Future<DirectusResponse<T>> readOne(String id, {OneQuery? query}) async {
    return DirectusResponse.fromRequest<T>(
      () => client.get(
        '$_endpoint/$id',
        queryParameters: query?.toMap(),
      ),
      converter: converter,
    );
  }

  /// Get many items
  ///
  /// ```dart
  /// await this.readMany();
  ///
  /// await readMany(
  ///     filters: Filters({'id': F.isIn(['1', '2', '3'])})
  /// );
  ///
  /// await this.readMany(
  ///   query: Query(limit: 5),
  ///   filters: Filters({
  ///     'name': eq('Test')
  ///   }),
  /// );
  /// ```
  Future<DirectusListResponse<T>> readMany({
    Query? query,
    Filters? filters,
  }) async {
    query ??= Query();
    return DirectusListResponse.fromRequest(
      () => client.get(
        _endpoint,
        queryParameters: query!.toMap(filters: filters),
      ),
      converter: converter,
    );
  }

  /// Create one item
  ///
  /// ```dart
  /// await items.createOne({'name': 'Test'});
  /// ```
  Future<DirectusResponse<T>> createOne(T data) async {
    final mapData = converter.toJson(data);
    return DirectusResponse.fromRequest(
      () => client.post(_endpoint, data: mapData),
      converter: converter,
    );
  }

  /// Create many items
  ///
  /// ```dart
  /// await items.createMany([{'name': 'Test One'}, {'name': 'Test Two'}]);
  /// ```
  Future<DirectusListResponse<T>> createMany(List<T> data) async {
    final mapData = data.map((item) => converter.toJson(item)).toList();
    return DirectusListResponse.fromRequest<T>(
      () => client.post(_endpoint, data: mapData),
      converter: converter,
    );
  }

  /// Update single item
  ///
  /// ```dart
  /// await items.updateOne(id: '5', data: {'name': 'Test'});
  /// ```
  Future<DirectusResponse<T>> updateOne(
      {required T data, required String id}) async {
    final mapData = converter.toJson(data);
    return DirectusResponse.fromRequest(
      () => client.patch('$_endpoint/$id', data: mapData),
      converter: converter,
    );
  }

  /// Update many items
  ///
  /// ```dart
  /// await items.updateMany(ids: ['5', '6', '7'], data: {'name': 'Test'});
  /// ```
  Future<DirectusListResponse<T>> updateMany(
      {required List<String> ids, required T data}) async {
    if (ids.isEmpty) return DirectusListResponse.manually([]);

    final mapData = converter.toJson(data);

    return DirectusListResponse.fromRequest(
      () => client.patch(_endpoint, //
          data: {
            "data": mapData, "keys": ids //
          }),
      converter: converter,
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
    if (ids.isEmpty) return;

    try {
      await client.delete('$_endpoint/${ids.join(',')}');
    } catch (e) {
      throw DirectusError.fromDio(e);
    }
  }
}
