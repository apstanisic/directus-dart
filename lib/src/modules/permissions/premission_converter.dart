import 'package:directus/src/modules/items/items_converter.dart';

import 'directus_permission.dart';

class PermissionConverter implements ItemsConverter<DirectusPermission> {
  @override
  Map<String, dynamic> toJson(data) => data.toJson();

  @override
  DirectusPermission fromJson(Map<String, dynamic> data) =>
      DirectusPermission.fromJson(data);
}
