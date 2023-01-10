import 'package:directus_core/src/modules/items/items_converter.dart';

import 'directus_preset.dart';

class PresetConverter implements ItemsConverter<DirectusPreset> {
  @override
  Map<String, Object?> toJson(data) => data.toJson();

  @override
  DirectusPreset fromJson(Map<String, Object?> data) =>
      DirectusPreset.fromJson(data);
}
