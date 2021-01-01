import 'package:directus/src/modules/items/items_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'directus_folder.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DirectusFolder {
  String? id;
  String? name;
  String? parent;

  DirectusFolder({
    this.id,
    this.name,
    this.parent,
  });

  /// Used for code generation
  factory DirectusFolder.fromJson(Map<String, dynamic> json) => _$DirectusFolderFromJson(json);

  /// Used for code generation
  Map<String, dynamic> toJson() => _$DirectusFolderToJson(this);
}

class FolderConverter implements ItemsConverter<DirectusFolder> {
  @override
  Map<String, dynamic> toJson(data) => data.toJson();

  @override
  DirectusFolder fromJson(Map<String, dynamic> data) => DirectusFolder.fromJson(data);
}
