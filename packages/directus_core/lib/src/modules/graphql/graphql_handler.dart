import 'package:dio/dio.dart';
import 'package:directus_core/directus_core.dart';
import 'package:directus_core/src/modules/items/map_items_converter.dart';
import 'package:meta/meta.dart';

class GraphQLHandler<T> {
  /// HTTP Client
  @protected
  Dio client;

  /// Used to convert object from and to [Map].
  ItemsConverter converter;

  GraphQLHandler({
    required this.client,
    ItemsConverter? converter,
  }) : converter = converter ?? MapItemsConverter();

  /// Used to query on collections
  Future<DirectusResponse<T>> query(String query) async {
    return DirectusResponse.fromRequest(
      () => client.get(
        'graphql',
        queryParameters: {
          'query': query,
        },
      ),
      converter: converter,
    );
  }

  /// Used to query on directus collections
  Future<DirectusResponse<T>> systemQuery(String query) async {
    return DirectusResponse.fromRequest(
      () => client.get(
        'graphql/system',
        queryParameters: {
          'query': query,
        },
      ),
      converter: converter,
    );
  }
}
