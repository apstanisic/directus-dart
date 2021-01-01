import 'package:directus/src/modules/files/files_handler.dart';
import 'package:directus/src/modules/items/items_handler.dart';
import 'package:test/test.dart';

import '../../mock/mock_dio.dart';

void main() {
  test('that FilesHandler extends ItemsHandler.', () async {
    final files = FilesHandler(client: MockDio());

    expect(files, isA<ItemsHandler>());
  });
}
