import 'package:directus/src/modules/collections/directus_collection.dart';
import 'package:directus/src/modules/items/items_converter.dart';

class CollectionConverter implements ItemsConverter<DirectusCollection> {
  @override
  Map<String, dynamic> toJson(data) => data.toJson();

  @override
  DirectusCollection fromJson(Map<String, dynamic> data) => DirectusCollection.fromJson(data);
}
