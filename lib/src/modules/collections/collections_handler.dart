// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/modules/items/items_handler.dart';

import 'directus_collection.dart';

class CollectionsHandler extends ItemsHandler<DirectusCollection> {
  CollectionsHandler({required Dio client})
      : super(
          'directus_collections',
          client: client,
          converter: CollectionConverter(),
        );
}
