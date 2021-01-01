// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/items/directus_revision.dart';
import 'package:directus/src/handlers/items_handler.dart';

class RevisionsHandler extends ItemsHandler<DirectusRevision> {
  RevisionsHandler({required Dio client})
      : super(
          'directus_revisions',
          client: client,
          converter: RevisionConverter(),
        );
}
