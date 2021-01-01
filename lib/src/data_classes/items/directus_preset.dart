import 'package:directus/src/utils/items_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'directus_preset.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DirectusPreset {
  int? id;
  String? bookmark;
  String? user;
  String? role;
  String? collection;
  String? search;
  List<Map<String, dynamic>>? filters;
  String? layout;
  Map<String, dynamic>? layoutQuery;
  Map<String, dynamic>? layoutOptions;

  DirectusPreset({
    this.id,
    this.bookmark,
    this.user,
    this.role,
    this.collection,
    this.search,
    this.filters,
    this.layout,
    this.layoutQuery,
    this.layoutOptions,
  });

  /// Used for code generation
  factory DirectusPreset.fromJson(Map<String, dynamic> json) => _$DirectusPresetFromJson(json);

  /// Used for code generation
  Map<String, dynamic> toJson() => _$DirectusPresetToJson(this);
}

class PresetConverter implements ItemsConverter<DirectusPreset> {
  @override
  Map<String, dynamic> toJson(data) {
    return data.toJson();
  }

  @override
  DirectusPreset fromJson(Map<String, dynamic> data) {
    return DirectusPreset.fromJson(data);
  }
}
