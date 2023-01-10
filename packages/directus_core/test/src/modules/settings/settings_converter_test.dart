import 'package:directus_core/src/modules/settings/directus_settings.dart';
import 'package:directus_core/src/modules/settings/settings_converter.dart';
import 'package:test/test.dart';

void main() {
  test('SettingsConverter', () {
    final converter = SettingsConverter();
    final settingsMap = converter.toJson(DirectusSettings(id: 1));
    expect(settingsMap, isMap);
    final settings = converter.fromJson(settingsMap);
    expect(settings, isA<DirectusSettings>());
  });
}
