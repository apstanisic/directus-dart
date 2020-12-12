import 'package:dio/dio.dart';
import 'package:directus/src/handlers/items_handler.dart';

class RolesHandler extends ItemsHandler {
  RolesHandler({Dio? client}) : super('directus_roles', client: client);
}
