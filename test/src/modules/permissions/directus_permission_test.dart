import 'package:directus/src/modules/permissions/directus_permission.dart';
import 'package:test/test.dart';

void main() {
  test('DirectusPermission', () async {
    final permission = DirectusPermission.fromJson({'id': 1});
    expect(permission, isA<DirectusPermission>());
    expect(permission.id, 1);
    final permissionMap = permission.toJson();
    expect(permissionMap, isMap);
  });

  test('PermissionConverter', () {
    final converter = PermissionConverter();
    final permissionMap = converter.toJson(DirectusPermission(id: 1));
    expect(permissionMap, isMap);
    final permission = converter.fromJson(permissionMap);
    expect(permission, isA<DirectusPermission>());
  });
}
