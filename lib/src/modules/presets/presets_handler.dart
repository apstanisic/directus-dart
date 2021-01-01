// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/modules/items/items_handler.dart';

import 'directus_preset.dart';

class PresetsHandler extends ItemsHandler<DirectusPreset> {
  PresetsHandler({required Dio client})
      : super(
          'directus_presets',
          client: client,
          converter: PresetConverter(),
        );
}
