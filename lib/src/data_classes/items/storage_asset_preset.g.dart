// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_asset_preset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StorageAssetPreset _$StorageAssetPresetFromJson(Map<String, dynamic> json) {
  return StorageAssetPreset(
    fit: json['fit'] as String,
    key: json['key'] as String,
    width: json['width'] as int,
    height: json['height'] as int,
    quality: json['quality'] as int,
    withoutEnlargement: json['withoutEnlargement'] as bool,
  );
}

Map<String, dynamic> _$StorageAssetPresetToJson(StorageAssetPreset instance) =>
    <String, dynamic>{
      'key': instance.key,
      'fit': instance.fit,
      'width': instance.width,
      'height': instance.height,
      'quality': instance.quality,
      'withoutEnlargement': instance.withoutEnlargement,
    };
