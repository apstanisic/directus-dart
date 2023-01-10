import 'package:directus_core/src/modules/items/items_handler.dart';
import 'package:directus_core/src/modules/roles/roles_handler.dart';
import 'package:test/test.dart';

import '../../mock/mocks.mocks.dart';

void main() {
  test('that RolesHandler extends ItemsHandler.', () async {
    final roles = RolesHandler(client: MockDio());

    expect(roles, isA<ItemsHandler>());
  });
}
