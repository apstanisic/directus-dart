import 'package:directus_core/src/modules/items/items_converter.dart';

import 'directus_file.dart';

class FileConverter implements ItemsConverter<DirectusFile> {
  @override
  Map<String, Object?> toJson(data) => data.toJson();

  @override
  DirectusFile fromJson(Map<String, Object?> data) {
    return DirectusFile.fromJson(data);
  }
}
