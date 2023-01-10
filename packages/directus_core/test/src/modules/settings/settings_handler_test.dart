import 'package:directus_core/src/modules/settings/settings_handler.dart';
import 'package:test/test.dart';

import '../../mock/mocks.mocks.dart';

void main() {
  test('that SettingsHandler extends ItemsHandler.', () async {
    final settings = SettingsHandler(client: MockDio());

    expect(settings, isA<SettingsHandler>());
  });
}
