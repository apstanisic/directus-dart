import 'package:directus_core/src/modules/items/items_converter.dart';

import 'directus_user.dart';

class UserConverter implements ItemsConverter<DirectusUser> {
  @override
  Map<String, Object?> toJson(data) => data.toJson();

  @override
  DirectusUser fromJson(Map<String, Object?> data) =>
      DirectusUser.fromJson(data);
}
