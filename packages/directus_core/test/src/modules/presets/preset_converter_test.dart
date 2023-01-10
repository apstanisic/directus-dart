import 'package:directus_core/src/modules/presets/directus_preset.dart';
import 'package:directus_core/src/modules/presets/preset_converter.dart';
import 'package:test/test.dart';

void main() {
  test('PresetConverter', () {
    final converter = PresetConverter();
    final presetMap = converter.toJson(DirectusPreset(id: 1));
    expect(presetMap, isMap);
    final preset = converter.fromJson(presetMap);
    expect(preset, isA<DirectusPreset>());
  });
}
