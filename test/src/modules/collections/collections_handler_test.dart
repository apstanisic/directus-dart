import 'package:directus/src/modules/collections/collections_handler.dart';
import 'package:directus/src/modules/items/items_handler.dart';
import 'package:test/test.dart';

import '../../mock/mock_dio.dart';

void main() {
  test('that CollectionsHandler extends ItemsHandler.', () async {
    final collections = CollectionsHandler(client: MockDio());

    expect(collections, isA<ItemsHandler>());
  });
}
