import 'package:json_annotation/json_annotation.dart';

part 'directus_user.g.dart';

// getRawValues(Map<dynamic, dynamic> allValues, String key) {
//   return allValues;
// }

// dynamic rawToJson(dynamic val) {
//   return null;
// }

@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
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

  /// Either [String] or [DirectusFile].
  Object? avatar;
  String? language;
  String? theme;
  String? status;

  /// Role is either [String] or [DirectusRole].
  Object? role;

  /// Raw values are values before transformation
  ///
  /// They can be useful when you have additional columns in db
  /// You can also set this property when you want to create/update user
  /// with your custom columns.
  /// THIS WILL NOT CAMEL-CASE values, they will be sent the same way
  /// they are set
  // @experimental
  // @JsonKey(readValue: getRawValues, includeIfNull: true, toJson: rawToJson)
  // Map<String, Object?> rawValues = {};

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
    // this.rawValues = const {},
  });

  /// Used for code generation
  factory DirectusUser.fromJson(Map<String, Object?> json) =>
      _$DirectusUserFromJson(json);

  /// Used for code generation
  Map<String, Object?> toJson() => _$DirectusUserToJson(this);
  // {...rawValues, ..._$DirectusUserToJson(this)};
}
