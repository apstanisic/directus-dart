import 'package:directus/src/modules/presets/directus_preset.dart';
import 'package:test/test.dart';

void main() {
  test('DirectusPreset', () async {
    final preset = DirectusPreset.fromJson({'id': 1});
    expect(preset, isA<DirectusPreset>());
    expect(preset.id, 1);
    final presetMap = preset.toJson();
    expect(presetMap, isMap);
  });

  test('PresetConverter', () {
    final converter = PresetConverter();
    final presetMap = converter.toJson(DirectusPreset(id: 1));
    expect(presetMap, isMap);
    final preset = converter.fromJson(presetMap);
    expect(preset, isA<DirectusPreset>());
  });
}
