import 'package:directus/src/handlers/items_handler.dart';
import 'package:directus/src/handlers/presets_handler.dart';
import 'package:test/test.dart';

import '../mock/mock_dio.dart';

void main() {
  test('PresetsHandler have all methods of ItemsHandler', () async {
    final presets = PresetsHandler(client: MockDio());

    expect(presets, isA<ItemsHandler>());
  });
}
