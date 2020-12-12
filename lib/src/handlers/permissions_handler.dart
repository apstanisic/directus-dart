import 'package:dio/dio.dart';
import 'package:directus/src/handlers/items_handler.dart';

class PermissionsHandler extends ItemsHandler {
  PermissionsHandler({Dio? client}) : super('directus_permissions', client: client);
}
