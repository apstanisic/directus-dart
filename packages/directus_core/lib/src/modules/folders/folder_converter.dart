import 'package:directus_core/src/modules/items/items_converter.dart';

import 'directus_folder.dart';

class FolderConverter implements ItemsConverter<DirectusFolder> {
  @override
  Map<String, Object?> toJson(data) => data.toJson();

  @override
  DirectusFolder fromJson(Map<String, Object?> data) =>
      DirectusFolder.fromJson(data);
}
