import 'package:directus/src/modules/items/items_converter.dart';

import 'directus_activity.dart';

class ActivityConverter implements ItemsConverter<DirectusActivity> {
  @override
  Map<String, dynamic> toJson(data) => data.toJson();

  @override
  DirectusActivity fromJson(Map<String, dynamic> data) => DirectusActivity.fromJson(data);
}
