import 'package:directus_core/src/modules/items/items_converter.dart';

import 'directus_permission.dart';

class PermissionConverter implements ItemsConverter<DirectusPermission> {
  @override
  Map<String, Object?> toJson(data) => data.toJson();

  @override
  DirectusPermission fromJson(Map<String, Object?> data) =>
      DirectusPermission.fromJson(data);
}
