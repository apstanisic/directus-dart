import 'package:json_annotation/json_annotation.dart';

part 'directus_permission.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DirectusPermission {
  int? id;

  /// Role ID
  ///
  /// Currently (January 2021) only [String], but in future it could be [DirectusRole].
  String? role;

  /// Collection name.
  ///
  /// NOT FK to [DirectusCollection].
  String? collection;
  String? action;
  Map<String, Object?>? permissions;
  Map<String, Object?>? validation;
  Map<String, Object?>? presets;
  List<String>? fields;
  int? limit;

  DirectusPermission({
    this.id,
    this.role,
    this.collection,
    this.action,
    this.permissions,
    this.validation,
    this.presets,
    this.fields,
    this.limit,
  });

  /// Used for code generation
  factory DirectusPermission.fromJson(Map<String, Object?> json) =>
      _$DirectusPermissionFromJson(json);

  /// Used for code generation
  Map<String, Object?> toJson() => _$DirectusPermissionToJson(this);
}
