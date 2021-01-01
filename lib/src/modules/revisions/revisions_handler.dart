// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/modules/items/items_handler.dart';

import 'directus_revision.dart';

class RevisionsHandler extends ItemsHandler<DirectusRevision> {
  RevisionsHandler({required Dio client})
      : super(
          'directus_revisions',
          client: client,
          converter: RevisionConverter(),
        );
}
