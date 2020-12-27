import 'package:directus/src/handlers/items_handler.dart';
import 'package:directus/src/handlers/settings_handler.dart';
import 'package:test/test.dart';

import '../mock/mock_dio.dart';

void main() {
  test('that SettingsHandler extends ItemsHandler.', () async {
    final settings = SettingsHandler(client: MockDio());

    expect(settings, isA<ItemsHandler>());
  });
}
