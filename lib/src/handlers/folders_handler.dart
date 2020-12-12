import 'package:dio/dio.dart';
import 'package:directus/src/handlers/items_handler.dart';

class FoldersHandler extends ItemsHandler {
  FoldersHandler({Dio? client}) : super('directus_folders', client: client);
}
