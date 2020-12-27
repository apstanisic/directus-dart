// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/handlers/items_handler.dart';

class RevisionsHandler extends ItemsHandler {
  RevisionsHandler({required Dio client}) : super('directus_revisions', client: client);
}
