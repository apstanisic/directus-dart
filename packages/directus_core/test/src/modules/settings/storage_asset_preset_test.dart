import 'package:directus_core/src/modules/settings/storage_asset_preset.dart';
import 'package:test/test.dart';

void main() {
  test('StorageAssetPreset', () async {
    final item = StorageAssetPreset(
      fit: 'cover',
      height: 100,
      key: 'xl',
      quality: 80,
      width: 100,
      withoutEnlargement: true,
    );
    final asMap = item.toJson();
    expect(asMap, isMap);
    final asObject = StorageAssetPreset.fromJson(item.toJson());
    expect(asObject, isA<StorageAssetPreset>());
  });
}
