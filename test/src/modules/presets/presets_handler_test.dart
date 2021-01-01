import 'package:directus/src/modules/items/items_handler.dart';
import 'package:directus/src/modules/presets/presets_handler.dart';
import 'package:test/test.dart';

import '../../mock/mock_dio.dart';

void main() {
  test('that PresetsHandler extends ItemsHandler.', () async {
    final presets = PresetsHandler(client: MockDio());

    expect(presets, isA<ItemsHandler>());
  });
}
