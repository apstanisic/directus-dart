import 'package:directus_core/src/modules/settings/storage_asset_preset.dart';
import 'package:json_annotation/json_annotation.dart';

part 'directus_settings.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DirectusSettings {
  int? id;
  String? projectName;
  String? projectUrl;
  String? projectColor;
  String? projectLogo;
  String? publicForeground;
  String? publicBackground;
  String? publicNote;
  int? authLoginAttempts;
  String? authPasswordPolicy;
  String? storageAssetTransform;
  List<StorageAssetPreset>? storageAssetPresets;
  String? customCss;

  DirectusSettings({
    this.id,
    this.projectName,
    this.projectUrl,
    this.projectColor,
    this.projectLogo,
    this.publicForeground,
    this.publicBackground,
    this.publicNote,
    this.authLoginAttempts,
    this.authPasswordPolicy,
    this.storageAssetTransform,
    this.storageAssetPresets,
    this.customCss,
  });

  /// Used for code generation
  factory DirectusSettings.fromJson(Map<String, Object?> json) =>
      _$DirectusSettingsFromJson(json);

  /// Used for code generation
  Map<String, Object?> toJson() => _$DirectusSettingsToJson(this);
}
