import 'package:dio/dio.dart';
import 'package:directus_core/src/data_classes/directus_response.dart';
import 'package:directus_core/src/modules/items/items_handler.dart';
import 'package:directus_core/src/modules/settings/settings_converter.dart';
import 'package:meta/meta.dart';

import 'directus_settings.dart';

/// Handler for settings
class SettingsHandler {
  @visibleForTesting
  ItemsHandler<DirectusSettings> items;

  SettingsHandler({required Dio client})
      : items = ItemsHandler(
          'directus_settings',
          client: client,
          converter: SettingsConverter(),
        );

  Future<DirectusResponse<DirectusSettings>> read() => items.readOne('1');

  Future<DirectusResponse<DirectusSettings>> update(DirectusSettings data) =>
      items.updateOne(data: data, id: '1');
}
