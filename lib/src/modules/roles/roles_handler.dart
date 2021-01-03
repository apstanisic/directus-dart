// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/modules/items/items_handler.dart';
import 'package:directus/src/modules/roles/role_converter.dart';

import 'directus_role.dart';

class RolesHandler extends ItemsHandler<DirectusRole> {
  RolesHandler({required Dio client})
      : super(
          'directus_roles',
          client: client,
          converter: RoleConverter(),
        );
}
