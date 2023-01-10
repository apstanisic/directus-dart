import 'package:directus_core/src/modules/folders/folders_handler.dart';
import 'package:directus_core/src/modules/items/items_handler.dart';
import 'package:test/test.dart';

import '../../mock/mocks.mocks.dart';

void main() {
  test('that FoldersHandler extends ItemsHandler.', () async {
    final folders = FoldersHandler(client: MockDio());

    expect(folders, isA<ItemsHandler>());
  });
}
