// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/handlers/items_handler.dart';

class RolesHandler extends ItemsHandler {
  RolesHandler({required Dio client}) : super('directus_roles', client: client);
}
