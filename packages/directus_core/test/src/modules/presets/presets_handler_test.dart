import 'package:directus_core/src/modules/items/items_handler.dart';
import 'package:directus_core/src/modules/presets/presets_handler.dart';
import 'package:test/test.dart';

import '../../mock/mocks.mocks.dart';

void main() {
  test('that PresetsHandler extends ItemsHandler.', () async {
    final presets = PresetsHandler(client: MockDio());

    expect(presets, isA<ItemsHandler>());
  });
}
