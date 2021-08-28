import 'package:directus/src/modules/items/items_converter.dart';

import 'directus_revision.dart';

class RevisionConverter implements ItemsConverter<DirectusRevision> {
  @override
  Map<String, dynamic> toJson(data) => data.toJson();

  @override
  DirectusRevision fromJson(Map<String, dynamic> data) =>
      DirectusRevision.fromJson(data);
}
