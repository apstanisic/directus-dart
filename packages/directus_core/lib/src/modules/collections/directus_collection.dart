import 'package:json_annotation/json_annotation.dart';

part 'directus_collection.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DirectusCollection {
  /// Collection name.
  ///
  /// It is not a FK to [DirectusCollection].
  String? collection;
  String? icon;
  String? note;
  String? displayTemplate;
  bool? hidden;
  bool? singleton;
  List<Map<String, Object?>>? translations;
  String? archiveField;
  bool? archiveAppFilter;
  String? archiveValue;
  String? unarchiveValue;
  String? sortField;

  DirectusCollection({
    this.archiveAppFilter,
    this.archiveField,
    this.archiveValue,
    this.collection,
    this.displayTemplate,
    this.hidden,
    this.icon,
    this.note,
    this.singleton,
    this.sortField,
    this.translations,
    this.unarchiveValue,
  });

  /// Used for code generation
  factory DirectusCollection.fromJson(Map<String, Object?> json) =>
      _$DirectusCollectionFromJson(json);

  /// Used for code generation
  Map<String, Object?> toJson() => _$DirectusCollectionToJson(this);
}
