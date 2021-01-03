import 'package:json_annotation/json_annotation.dart';

part 'directus_role.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DirectusRole {
  String? id;
  String? name;
  String? icon;
  String? description;
  String? ipAccess;
  bool? enforceTfa;
  List<Map<String, dynamic>>? moduleList;
  List<Map<String, dynamic>>? collectionList;
  bool? adminAccess;
  bool? appAccess;

  DirectusRole({
    this.id,
    this.name,
    this.icon,
    this.description,
    this.ipAccess,
    this.enforceTfa,
    this.moduleList,
    this.collectionList,
    this.adminAccess,
    this.appAccess,
  });

  /// Used for code generation
  factory DirectusRole.fromJson(Map<String, dynamic> json) => _$DirectusRoleFromJson(json);

  /// Used for code generation
  Map<String, dynamic> toJson() => _$DirectusRoleToJson(this);
}
