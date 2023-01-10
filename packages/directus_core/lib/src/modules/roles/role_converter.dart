import 'package:directus_core/src/modules/items/items_converter.dart';

import 'directus_role.dart';

class RoleConverter implements ItemsConverter<DirectusRole> {
  @override
  Map<String, Object?> toJson(data) => data.toJson();

  @override
  DirectusRole fromJson(Map<String, Object?> data) =>
      DirectusRole.fromJson(data);
}
