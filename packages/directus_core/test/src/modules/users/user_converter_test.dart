import 'package:directus_core/src/modules/users/directus_user.dart';
import 'package:directus_core/src/modules/users/user_converter.dart';
import 'package:test/test.dart';

void main() {
  test('UsersConverter', () {
    final converter = UserConverter();
    final usersMap = converter.toJson(DirectusUser(id: '1'));
    expect(usersMap, isMap);
    final users = converter.fromJson(usersMap);
    expect(users, isA<DirectusUser>());
  });
}
