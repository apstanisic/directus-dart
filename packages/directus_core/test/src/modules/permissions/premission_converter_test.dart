import 'package:directus_core/src/modules/permissions/directus_permission.dart';
import 'package:directus_core/src/modules/permissions/premission_converter.dart';
import 'package:test/test.dart';

void main() {
  test('PermissionConverter', () {
    final converter = PermissionConverter();
    final permissionMap = converter.toJson(DirectusPermission(id: 1));
    expect(permissionMap, isMap);
    final permission = converter.fromJson(permissionMap);
    expect(permission, isA<DirectusPermission>());
  });
}
