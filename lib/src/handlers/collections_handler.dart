// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/items/directus_collection.dart';
import 'package:directus/src/handlers/items_handler.dart';

class CollectionsHandler extends ItemsHandler<DirectusCollection> {
  CollectionsHandler({required Dio client})
      : super(
          'directus_collections',
          client: client,
          converter: CollectionConverter(),
        );
}
