import 'package:directus_core/src/modules/roles/directus_role.dart';
import 'package:test/test.dart';

void main() {
  test('DirectusRole', () async {
    final role = DirectusRole.fromJson({'id': '1'});
    expect(role, isA<DirectusRole>());
    expect(role.id, '1');
    final roleMap = role.toJson();
    expect(roleMap, isMap);
  });
}
