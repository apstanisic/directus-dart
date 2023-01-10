import 'package:directus_core/src/modules/users/directus_user.dart';
import 'package:test/test.dart';

void main() {
  test('DirectusUser', () async {
    final settings = DirectusUser.fromJson({'id': '1'});
    expect(settings, isA<DirectusUser>());
    expect(settings.id, '1');
    final settingsMap = settings.toJson();
    expect(settingsMap, isMap);
  });
}
