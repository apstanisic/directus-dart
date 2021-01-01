// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/modules/items/items_handler.dart';

import 'directus_file.dart';

class FilesHandler extends ItemsHandler<DirectusFile> {
  FilesHandler({required Dio client})
      : super(
          'directus_files',
          client: client,
          converter: FileConverter(),
        );
}
