import 'package:directus/src/modules/settings/directus_settings.dart';
import 'package:test/test.dart';

void main() {
  test('DirectusSettings', () async {
    final settings = DirectusSettings.fromJson({'id': 1});
    expect(settings, isA<DirectusSettings>());
    expect(settings.id, 1);
    final settingsMap = settings.toJson();
    expect(settingsMap, isMap);
  });

  test('SettingsConverter', () {
    final converter = SettingsConverter();
    final settingsMap = converter.toJson(DirectusSettings(id: 1));
    expect(settingsMap, isMap);
    final settings = converter.fromJson(settingsMap);
    expect(settings, isA<DirectusSettings>());
  });
}
