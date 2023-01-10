import 'package:directus_core/src/modules/items/items_converter.dart';

import 'directus_activity.dart';

class ActivityConverter implements ItemsConverter<DirectusActivity> {
  @override
  Map<String, Object?> toJson(data) => data.toJson();

  @override
  DirectusActivity fromJson(Map<String, Object?> data) =>
      DirectusActivity.fromJson(data);
}
