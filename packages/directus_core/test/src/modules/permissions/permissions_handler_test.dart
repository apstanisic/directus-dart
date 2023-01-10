import 'package:directus_core/src/modules/items/items_handler.dart';
import 'package:directus_core/src/modules/permissions/permissions_handler.dart';
import 'package:test/test.dart';

import '../../mock/mocks.mocks.dart';

void main() {
  test('that PermissionsHandler extends ItemsHandler.', () async {
    final permissions = PermissionsHandler(client: MockDio());

    expect(permissions, isA<ItemsHandler>());
  });
}
