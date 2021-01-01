import 'package:directus/src/modules/items/items_handler.dart';
import 'package:directus/src/modules/revisions/revisions_handler.dart';
import 'package:test/test.dart';

import '../../mock/mock_dio.dart';

void main() {
  test('that RevisionsHandler extends ItemsHandler', () async {
    final revisions = RevisionsHandler(client: MockDio());

    expect(revisions, isA<ItemsHandler>());
  });
}
