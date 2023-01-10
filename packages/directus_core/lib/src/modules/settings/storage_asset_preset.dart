import 'package:json_annotation/json_annotation.dart';

part 'storage_asset_preset.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class StorageAssetPreset {
  String key;
  String fit;
  int width;
  int height;
  int quality;
  bool withoutEnlargement;

  StorageAssetPreset({
    required this.fit,
    required this.key,
    required this.width,
    required this.height,
    required this.quality,
    required this.withoutEnlargement,
  });

  /// Used for code generation
  factory StorageAssetPreset.fromJson(Map<String, Object?> json) =>
      _$StorageAssetPresetFromJson(json);

  /// Used for code generation
  Map<String, Object?> toJson() => _$StorageAssetPresetToJson(this);
}
