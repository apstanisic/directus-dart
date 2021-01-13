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
  Map<String, dynamic>? permissions;
  Map<String, dynamic>? validation;
  Map<String, dynamic>? presets;
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
  factory DirectusPermission.fromJson(Map<String, dynamic> json) =>
      _$DirectusPermissionFromJson(json);

  /// Used for code generation
  Map<String, dynamic> toJson() => _$DirectusPermissionToJson(this);
}
