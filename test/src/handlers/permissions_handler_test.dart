import 'package:directus/src/handlers/items_handler.dart';
import 'package:directus/src/handlers/permissions_handler.dart';
import 'package:test/test.dart';

import '../mock/mock_dio.dart';

void main() {
  test('PermissionsHandler have all methods of ItemsHandler', () async {
    final permissions = PermissionsHandler(client: MockDio());

    expect(permissions, isA<ItemsHandler>());
  });
}
