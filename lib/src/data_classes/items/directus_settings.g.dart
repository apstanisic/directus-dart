// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusSettings _$DirectusSettingsFromJson(Map<String, dynamic> json) {
  return DirectusSettings(
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
}

Map<String, dynamic> _$DirectusSettingsToJson(DirectusSettings instance) =>
    <String, dynamic>{
      'id': instance.id,
      'project_name': instance.projectName,
      'project_url': instance.projectUrl,
      'project_color': instance.projectColor,
      'project_logo': instance.projectLogo,
      'public_foreground': instance.publicForeground,
      'public_background': instance.publicBackground,
      'public_note': instance.publicNote,
      'auth_login_attempts': instance.authLoginAttempts,
      'auth_password_policy': instance.authPasswordPolicy,
      'storage_asset_transform': instance.storageAssetTransform,
      'storage_asset_presets': instance.storageAssetPresets,
      'custom_css': instance.customCss,
    };
