import 'package:directus_core/src/modules/items/items_converter.dart';

import 'directus_relation.dart';

class RelationConverter implements ItemsConverter<DirectusRelation> {
  @override
  Map<String, Object?> toJson(data) => data.toJson();

  @override
  DirectusRelation fromJson(Map<String, Object?> data) =>
      DirectusRelation.fromJson(data);
}
