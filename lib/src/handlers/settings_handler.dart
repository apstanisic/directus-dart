import 'package:dio/dio.dart';
import 'package:directus/src/collections/settings_item.dart';
import 'package:directus/src/handlers/items_handler.dart';

class SettingsHandler extends ItemsHandler {
  SettingsHandler({required Dio client}) : super('directus_settings', client: client);
}
