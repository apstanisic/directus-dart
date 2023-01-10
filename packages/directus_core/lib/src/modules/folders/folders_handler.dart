import 'package:dio/dio.dart';
import 'package:directus_core/src/modules/items/items_handler.dart';

import 'directus_folder.dart';
import 'folder_converter.dart';

class FoldersHandler extends ItemsHandler<DirectusFolder> {
  FoldersHandler({required Dio client})
      : super('directus_folders', client: client, converter: FolderConverter());
}
