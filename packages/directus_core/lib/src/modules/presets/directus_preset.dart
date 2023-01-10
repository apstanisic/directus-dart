import 'package:json_annotation/json_annotation.dart';

part 'directus_preset.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DirectusPreset {
  int? id;
  String? bookmark;

  /// User is either [String] or [DirectusUser].
  Object? user;

  /// User is either [String] or [DirectusRole].
  Object? role;
  String? collection;
  String? search;
  List<Map<String, Object?>>? filters;
  String? layout;
  Map<String, Object?>? layoutQuery;
  Map<String, Object?>? layoutOptions;

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
  factory DirectusPreset.fromJson(Map<String, Object?> json) =>
      _$DirectusPresetFromJson(json);

  /// Used for code generation
  Map<String, Object?> toJson() => _$DirectusPresetToJson(this);
}
