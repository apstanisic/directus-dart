import 'package:dio/dio.dart';
import 'package:directus/src/handlers/items_handler.dart';

class RevisionsHandler extends ItemsHandler {
  RevisionsHandler({Dio? client}) : super('directus_revisions', client: client);
}
