import 'package:dio/dio.dart';
import 'package:directus_core/src/modules/items/items_handler.dart';
import 'package:directus_core/src/modules/presets/preset_converter.dart';

import 'directus_preset.dart';

class PresetsHandler extends ItemsHandler<DirectusPreset> {
  PresetsHandler({required Dio client})
      : super(
          'directus_presets',
          client: client,
          converter: PresetConverter(),
        );
}
