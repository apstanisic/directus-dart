import 'package:directus_core/src/modules/collections/directus_collection.dart';
import 'package:directus_core/src/modules/items/items_converter.dart';

class CollectionConverter implements ItemsConverter<DirectusCollection> {
  @override
  Map<String, Object?> toJson(data) => data.toJson();

  @override
  DirectusCollection fromJson(Map<String, Object?> data) =>
      DirectusCollection.fromJson(data);
}
