import 'package:json_annotation/json_annotation.dart';

part 'directus_activity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DirectusActivity {
  int? id;
  String? action;
  String? user;
  DateTime? timestamp;
  String? ip;
  String? userAgent;
  String? collection;
  String? item;
  String? comment;

  DirectusActivity({
    this.action,
    this.collection,
    this.comment,
    this.id,
    this.ip,
    this.item,
    this.timestamp,
    this.user,
    this.userAgent,
  });

  /// Used for code generation
  factory DirectusActivity.fromJson(Map<String, dynamic> json) => _$DirectusActivityFromJson(json);

  /// Used for code generation
  Map<String, dynamic> toJson() => _$DirectusActivityToJson(this);
}
