import 'package:directus/src/handlers/items_handler.dart';
import 'package:directus/src/handlers/roles_handler.dart';
import 'package:test/test.dart';

import '../mock/mock_dio.dart';

void main() {
  test('RolesHandler have all methods of ItemsHandler', () async {
    final roles = RolesHandler(client: MockDio());

    expect(roles, isA<ItemsHandler>());
  });
}
