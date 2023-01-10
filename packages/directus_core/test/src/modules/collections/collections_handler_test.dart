import 'package:directus_core/src/modules/collections/collections_handler.dart';
import 'package:directus_core/src/modules/items/items_handler.dart';
import 'package:test/test.dart';

import '../../mock/mocks.mocks.dart';

void main() {
  test('that CollectionsHandler extends ItemsHandler.', () async {
    final collections = CollectionsHandler(client: MockDio());

    expect(collections, isA<ItemsHandler>());
  });
}
