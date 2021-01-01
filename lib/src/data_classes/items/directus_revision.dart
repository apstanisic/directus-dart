import 'package:directus/src/utils/items_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'directus_revision.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DirectusRevision {
  int? id;
  int? activity;
  String? collection;
  String? item;
  Map<String, dynamic>? data;
  Map<String, dynamic>? delta;
  int? parent;

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
  factory DirectusRevision.fromJson(Map<String, dynamic> json) => _$DirectusRevisionFromJson(json);

  /// Used for code generation
  Map<String, dynamic> toJson() => _$DirectusRevisionToJson(this);
}

class RevisionConverter implements ItemsConverter<DirectusRevision> {
  @override
  Map<String, dynamic> toJson(data) {
    return data.toJson();
  }

  @override
  DirectusRevision fromJson(Map<String, dynamic> data) {
    return DirectusRevision.fromJson(data);
  }
}
