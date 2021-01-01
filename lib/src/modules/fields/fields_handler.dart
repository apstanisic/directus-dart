// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/modules/files/directus_file.dart';
import 'package:directus/src/modules/items/items_handler.dart';

import 'directus_field.dart';

class FieldsHandler extends ItemsHandler<DirectusField> {
  FieldsHandler({required Dio client})
      : super(
          'directus_fields',
          client: client,
          converter: FileConverter(),
        );
}
