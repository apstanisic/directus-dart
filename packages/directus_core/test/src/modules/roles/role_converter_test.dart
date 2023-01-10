import 'package:directus_core/src/modules/roles/directus_role.dart';
import 'package:directus_core/src/modules/roles/role_converter.dart';
import 'package:test/test.dart';

void main() {
  test('RoleConverter', () {
    final converter = RoleConverter();
    final roleMap = converter.toJson(DirectusRole(id: '1'));
    expect(roleMap, isMap);
    final role = converter.fromJson(roleMap);
    expect(role, isA<DirectusRole>());
  });
}
