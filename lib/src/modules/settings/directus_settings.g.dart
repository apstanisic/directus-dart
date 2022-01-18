// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusSettings _$DirectusSettingsFromJson(Map<String, dynamic> json) =>
    DirectusSettings(
      id: json['id'] as int?,
      projectName: json['project_name'] as String?,
      projectUrl: json['project_url'] as String?,
      projectColor: json['project_color'] as String?,
      projectLogo: json['project_logo'] as String?,
      publicForeground: json['public_foreground'] as String?,
      publicBackground: json['public_background'] as String?,
      publicNote: json['public_note'] as String?,
      authLoginAttempts: json['auth_login_attempts'] as int?,
      authPasswordPolicy: json['auth_password_policy'] as String?,
      storageAssetTransform: json['storage_asset_transform'] as String?,
      storageAssetPresets: (json['storage_asset_presets'] as List<dynamic>?)
          ?.map((e) => StorageAssetPreset.fromJson(e as Map<String, dynamic>))
          .toList(),
      customCss: json['custom_css'] as String?,
    );

Map<String, dynamic> _$DirectusSettingsToJson(DirectusSettings instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('project_name', instance.projectName);
  writeNotNull('project_url', instance.projectUrl);
  writeNotNull('project_color', instance.projectColor);
  writeNotNull('project_logo', instance.projectLogo);
  writeNotNull('public_foreground', instance.publicForeground);
  writeNotNull('public_background', instance.publicBackground);
  writeNotNull('public_note', instance.publicNote);
  writeNotNull('auth_login_attempts', instance.authLoginAttempts);
  writeNotNull('auth_password_policy', instance.authPasswordPolicy);
  writeNotNull('storage_asset_transform', instance.storageAssetTransform);
  writeNotNull('storage_asset_presets', instance.storageAssetPresets);
  writeNotNull('custom_css', instance.customCss);
  return val;
}
