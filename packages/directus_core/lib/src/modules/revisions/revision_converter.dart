import 'package:directus_core/src/modules/items/items_converter.dart';

import 'directus_revision.dart';

class RevisionConverter implements ItemsConverter<DirectusRevision> {
  @override
  Map<String, Object?> toJson(data) => data.toJson();

  @override
  DirectusRevision fromJson(Map<String, Object?> data) =>
      DirectusRevision.fromJson(data);
}
