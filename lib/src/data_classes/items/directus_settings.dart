// class DirectusSettings {
//   Data data;

//   DirectusSettings({required this.data});

//   DirectusSettings.fromJson(Map<String, dynamic> json) {
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final  data = <String, dynamic>{};
//     if (this.data != null) {
//       data['data'] = this.data.toJson();
//     }
//     return data;
//   }
// }

import 'package:directus/src/data_classes/items/storage_asset_preset.dart';
import 'package:directus/src/utils/items_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'directus_settings.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
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
  factory DirectusSettings.fromJson(Map<String, dynamic> json) => _$DirectusSettingsFromJson(json);

  /// Used for code generation
  Map<String, dynamic> toJson() => _$DirectusSettingsToJson(this);
}

class SettingsConverter implements ItemsConverter<DirectusSettings> {
  @override
  Map<String, dynamic> toJson(data) {
    return data.toJson();
  }

  @override
  DirectusSettings fromJson(Map<String, dynamic> data) {
    return DirectusSettings.fromJson(data);
  }
}
