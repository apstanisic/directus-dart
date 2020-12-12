import 'package:dio/dio.dart';
import 'package:directus/src/handlers/items_handler.dart';

class FilesHandler extends ItemsHandler {
  FilesHandler({Dio? client}) : super('directus_files', client: client);
}
