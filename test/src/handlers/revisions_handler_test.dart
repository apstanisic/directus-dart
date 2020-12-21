import 'package:directus/src/handlers/items_handler.dart';
import 'package:directus/src/handlers/revisions_handler.dart';
import 'package:test/test.dart';

import '../mock/mock_dio.dart';

void main() {
  test('RevisionsHandler have all methods of ItemsHandler', () async {
    final revisions = RevisionsHandler(client: MockDio());

    expect(revisions, isA<ItemsHandler>());
  });
}
