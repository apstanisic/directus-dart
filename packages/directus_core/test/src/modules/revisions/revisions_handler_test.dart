import 'package:directus_core/src/modules/items/items_handler.dart';
import 'package:directus_core/src/modules/revisions/revisions_handler.dart';
import 'package:test/test.dart';

import '../../mock/mocks.mocks.dart';

void main() {
  test('that RevisionsHandler extends ItemsHandler', () async {
    final revisions = RevisionsHandler(client: MockDio());

    expect(revisions, isA<ItemsHandler>());
  });
}
