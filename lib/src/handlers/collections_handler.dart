import 'package:dio/dio.dart';
import 'package:directus/src/handlers/items_handler.dart';

class CollectionsHandler extends ItemsHandler {
  CollectionsHandler({Dio? client}) : super('directus_collections', client: client);
}
