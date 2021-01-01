import 'package:directus/src/utils/items_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'directus_user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DirectusUser {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? location;
  String? title;
  String? description;
  List<String>? tags;
  String? avatar;
  String? language;
  String? theme;
  String? status;
  String? role;

  DirectusUser({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.location,
    this.title,
    this.description,
    this.tags,
    this.avatar,
    this.language,
    this.theme,
    this.status,
    this.role,
  });

  /// Used for code generation
  factory DirectusUser.fromJson(Map<String, dynamic> json) => _$DirectusUserFromJson(json);

  /// Used for code generation
  Map<String, dynamic> toJson() => _$DirectusUserToJson(this);
}

class UserConverter implements ItemsConverter<DirectusUser> {
  @override
  Map<String, dynamic> toJson(data) => data.toJson();

  @override
  DirectusUser fromJson(Map<String, dynamic> data) => DirectusUser.fromJson(data);
}
