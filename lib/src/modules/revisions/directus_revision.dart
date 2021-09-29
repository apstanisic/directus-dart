import 'package:json_annotation/json_annotation.dart';

part 'directus_revision.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DirectusRevision {
  int? id;

  /// Activity is either [int] or [DirectusActivity].
  Object? activity;

  /// Collection name. NOT FK to [DirectusCollection].
  String? collection;

  /// Item is either [String]. It represents ID of item that is joined. Joining doesn't do anything.
  String? item;
  Map<String, Object?>? data;
  Map<String, Object?>? delta;

  /// Parent revision. It is either [int] or [DirectusRevision].
  Object? parent;

  DirectusRevision({
    this.id,
    this.activity,
    this.collection,
    this.item,
    this.data,
    this.delta,
    this.parent,
  });

  /// Used for code generation
  factory DirectusRevision.fromJson(Map<String, Object?> json) =>
      _$DirectusRevisionFromJson(json);

  /// Used for code generation
  Map<String, Object?> toJson() => _$DirectusRevisionToJson(this);
}
