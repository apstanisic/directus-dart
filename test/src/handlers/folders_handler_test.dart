import 'package:directus/src/handlers/items_handler.dart';
import 'package:directus/src/handlers/folders_handler.dart';
import 'package:test/test.dart';

import '../mock/mock_dio.dart';

void main() {
  test('that FoldersHandler extends ItemsHandler.', () async {
    final folders = FoldersHandler(client: MockDio());

    expect(folders, isA<ItemsHandler>());
  });
}
