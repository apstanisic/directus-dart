import 'package:dio/dio.dart';
import 'package:directus/src/handlers/items_handler.dart';

class PresetsHandler extends ItemsHandler {
  PresetsHandler({Dio? client}) : super('directus_presets', client: client);
}
