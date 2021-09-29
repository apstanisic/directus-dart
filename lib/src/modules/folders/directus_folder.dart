import 'package:json_annotation/json_annotation.dart';

part 'directus_folder.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DirectusFolder {
  /// Folder ID
  String? id;

  /// Folder name
  String? name;

  /// Parent folder.
  ///
  /// This field is [id] of parent item. It is either [String] or [DirectusFolder].
  Object? parent;

  DirectusFolder({
    this.id,
    this.name,
    this.parent,
  });

  /// Used for code generation
  factory DirectusFolder.fromJson(Map<String, Object?> json) =>
      _$DirectusFolderFromJson(json);

  /// Used for code generation
  Map<String, Object?> toJson() => _$DirectusFolderToJson(this);
}
