import 'package:dio/dio.dart';
import 'package:directus_core/src/modules/items/items_handler.dart';
import 'package:directus_core/src/modules/permissions/premission_converter.dart';

import 'directus_permission.dart';

class PermissionsHandler extends ItemsHandler<DirectusPermission> {
  PermissionsHandler({required Dio client})
      : super(
          'directus_permissions',
          client: client,
          converter: PermissionConverter(),
        );
}
