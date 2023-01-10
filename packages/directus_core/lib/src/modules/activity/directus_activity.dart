import 'package:json_annotation/json_annotation.dart';

part 'directus_activity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DirectusActivity {
  int? id;

  /// What action is performed. For example `create`
  String? action;

  /// User that performed action. Either [String] or [DirectusUser].
  Object? user;

  DateTime? timestamp;

  String? ip;

  String? userAgent;

  /// Name of the collection.
  ///
  /// It is NOT FK to [DirectusCollection].
  ///
  String? collection;

  /// It's [int] or [String].
  ///
  /// It is not connected to any other collection.
  /// At least not when this code is written (January 2021).
  Object? item;

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
  factory DirectusActivity.fromJson(Map<String, Object?> json) =>
      _$DirectusActivityFromJson(json);

  /// Used for code generation
  Map<String, Object?> toJson() => _$DirectusActivityToJson(this);
}
