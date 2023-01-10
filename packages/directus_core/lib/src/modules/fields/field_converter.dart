import 'package:directus_core/src/modules/items/items_converter.dart';

import 'directus_field.dart';

class FieldConverter implements ItemsConverter<DirectusField> {
  @override
  Map<String, Object?> toJson(data) => data.toJson();

  @override
  DirectusField fromJson(Map<String, Object?> data) =>
      DirectusField.fromJson(data);
}
