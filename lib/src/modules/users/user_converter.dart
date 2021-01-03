import 'package:directus/src/modules/items/items_converter.dart';

import 'directus_user.dart';

class UserConverter implements ItemsConverter<DirectusUser> {
  @override
  Map<String, dynamic> toJson(data) => data.toJson();

  @override
  DirectusUser fromJson(Map<String, dynamic> data) => DirectusUser.fromJson(data);
}
