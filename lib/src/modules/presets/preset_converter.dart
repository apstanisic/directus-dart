import 'package:directus/src/modules/items/items_converter.dart';

import 'directus_preset.dart';

class PresetConverter implements ItemsConverter<DirectusPreset> {
  @override
  Map<String, dynamic> toJson(data) => data.toJson();

  @override
  DirectusPreset fromJson(Map<String, dynamic> data) =>
      DirectusPreset.fromJson(data);
}
