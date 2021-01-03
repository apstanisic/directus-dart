import 'package:directus/src/modules/items/items_converter.dart';

import 'directus_relation.dart';

class RelationConverter implements ItemsConverter<DirectusRelation> {
  @override
  Map<String, dynamic> toJson(data) => data.toJson();

  @override
  DirectusRelation fromJson(Map<String, dynamic> data) => DirectusRelation.fromJson(data);
}
