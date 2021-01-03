import 'package:directus/src/modules/items/items_converter.dart';

import 'directus_role.dart';

class RoleConverter implements ItemsConverter<DirectusRole> {
  @override
  Map<String, dynamic> toJson(data) => data.toJson();

  @override
  DirectusRole fromJson(Map<String, dynamic> data) => DirectusRole.fromJson(data);
}
