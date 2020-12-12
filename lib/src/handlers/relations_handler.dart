import 'package:dio/dio.dart';
import 'package:directus/src/handlers/items_handler.dart';

class RelationsHandler extends ItemsHandler {
  RelationsHandler({Dio? client}) : super('directus_relations', client: client);
}
