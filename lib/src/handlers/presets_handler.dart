// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/items/directus_preset.dart';
import 'package:directus/src/handlers/items_handler.dart';

class PresetsHandler extends ItemsHandler<DirectusPreset> {
  PresetsHandler({required Dio client})
      : super(
          'directus_presets',
          client: client,
          converter: PresetConverter(),
        );
}
