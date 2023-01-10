import 'package:json_annotation/json_annotation.dart';

part 'directus_relation.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DirectusRelation {
  int? id;
  String? manyCollection;
  String? manyField;
  String? manyPrimary;
  String? oneCollection;
  String? oneField;
  String? onePrimary;
  String? oneCollectionField;
  String? oneAllowedCollections;
  String? junctionField;

  DirectusRelation({
    this.id,
    this.manyCollection,
    this.manyField,
    this.manyPrimary,
    this.oneCollection,
    this.oneField,
    this.onePrimary,
    this.oneCollectionField,
    this.oneAllowedCollections,
    this.junctionField,
  });

  /// Used for code generation
  factory DirectusRelation.fromJson(Map<String, Object?> json) =>
      _$DirectusRelationFromJson(json);

  /// Used for code generation
  Map<String, Object?> toJson() => _$DirectusRelationToJson(this);
}
