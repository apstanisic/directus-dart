import 'package:directus_core/src/modules/permissions/directus_permission.dart';
import 'package:test/test.dart';

void main() {
  test('DirectusPermission', () async {
    final permission = DirectusPermission.fromJson({'id': 1});
    expect(permission, isA<DirectusPermission>());
    expect(permission.id, 1);
    final permissionMap = permission.toJson();
    expect(permissionMap, isMap);
  });
}
