import 'package:dio/dio.dart';
import 'package:directus_core/src/modules/items/items_handler.dart';

import 'collection_converter.dart';
import 'directus_collection.dart';

class CollectionsHandler extends ItemsHandler<DirectusCollection> {
  CollectionsHandler({required Dio client})
      : super(
          'directus_collections',
          client: client,
          converter: CollectionConverter(),
        );
}
