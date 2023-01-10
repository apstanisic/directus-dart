import 'package:dio/dio.dart';
import 'package:directus_core/src/modules/items/items_handler.dart';

import 'directus_relation.dart';
import 'relation_converter.dart';

class RelationsHandler extends ItemsHandler<DirectusRelation> {
  RelationsHandler({required Dio client})
      : super(
          'directus_relations',
          client: client,
          converter: RelationConverter(),
        );
}
