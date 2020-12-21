import 'package:directus/src/handlers/items_handler.dart';
import 'package:directus/src/handlers/folders_handler.dart';
import 'package:test/test.dart';

import '../mock/mock_dio.dart';

void main() {
  test('FoldersHandler have all methods of ItemsHandler', () async {
    final folders = FoldersHandler(client: MockDio());

    expect(folders, isA<ItemsHandler>());
  });
}
