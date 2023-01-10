import 'package:dio/dio.dart';
import 'package:directus_core/src/modules/items/items_handler.dart';
import 'package:directus_core/src/modules/revisions/revision_converter.dart';

import 'directus_revision.dart';

class RevisionsHandler extends ItemsHandler<DirectusRevision> {
  RevisionsHandler({required Dio client})
      : super(
          'directus_revisions',
          client: client,
          converter: RevisionConverter(),
        );
}
