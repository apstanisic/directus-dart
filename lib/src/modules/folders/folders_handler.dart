// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/modules/items/items_handler.dart';

import 'directus_folder.dart';

class FoldersHandler extends ItemsHandler<DirectusFolder> {
  FoldersHandler({required Dio client})
      : super('directus_folders', client: client, converter: FolderConverter());
}
