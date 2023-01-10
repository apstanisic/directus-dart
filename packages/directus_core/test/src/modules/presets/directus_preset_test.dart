import 'package:directus_core/src/modules/presets/directus_preset.dart';
import 'package:test/test.dart';

void main() {
  test('DirectusPreset', () async {
    final preset = DirectusPreset.fromJson({'id': 1});
    expect(preset, isA<DirectusPreset>());
    expect(preset.id, 1);
    final presetMap = preset.toJson();
    expect(presetMap, isMap);
  });
}
