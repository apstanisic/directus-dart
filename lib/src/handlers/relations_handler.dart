// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/handlers/items_handler.dart';

class RelationsHandler extends ItemsHandler {
  RelationsHandler({required Dio client}) : super('directus_relations', client: client);
}
