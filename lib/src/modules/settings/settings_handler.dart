// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/directus_response.dart';
import 'package:directus/src/modules/items/items_handler.dart';
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
