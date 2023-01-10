import 'package:dio/dio.dart';
import 'package:directus_core/src/modules/fields/field_converter.dart';
import 'package:directus_core/src/modules/items/items_handler.dart';

import 'directus_field.dart';

class FieldsHandler extends ItemsHandler<DirectusField> {
  FieldsHandler({required Dio client})
      : super(
          'directus_fields',
          client: client,
          converter: FieldConverter(),
        );
}
