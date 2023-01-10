import 'package:directus_core/src/modules/items/items_converter.dart';

import 'directus_settings.dart';

class SettingsConverter implements ItemsConverter<DirectusSettings> {
  @override
  Map<String, Object?> toJson(data) => data.toJson();

  @override
  DirectusSettings fromJson(Map<String, Object?> data) =>
      DirectusSettings.fromJson(data);
}
