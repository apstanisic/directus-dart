import 'package:directus/src/modules/items/items_converter.dart';

import 'directus_settings.dart';

class SettingsConverter implements ItemsConverter<DirectusSettings> {
  @override
  Map<String, dynamic> toJson(data) => data.toJson();

  @override
  DirectusSettings fromJson(Map<String, dynamic> data) => DirectusSettings.fromJson(data);
}
