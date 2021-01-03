import 'package:directus/src/modules/items/items_converter.dart';

import 'directus_field.dart';

class FieldConverter implements ItemsConverter<DirectusField> {
  @override
  Map<String, dynamic> toJson(data) => data.toJson();

  @override
  DirectusField fromJson(Map<String, dynamic> data) => DirectusField.fromJson(data);
}
