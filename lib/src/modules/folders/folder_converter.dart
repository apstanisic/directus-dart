import 'package:directus/src/modules/items/items_converter.dart';

import 'directus_folder.dart';

class FolderConverter implements ItemsConverter<DirectusFolder> {
  @override
  Map<String, dynamic> toJson(data) => data.toJson();

  @override
  DirectusFolder fromJson(Map<String, dynamic> data) =>
      DirectusFolder.fromJson(data);
}
