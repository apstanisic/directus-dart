import 'package:directus/src/utils/items_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'directus_collection.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DirectusCollection {
  String? collection;
  String? icon;
  String? note;
  String? displayTemplate;
  bool? hidden;
  bool? singleton;
  List<Map<String, dynamic>>? translations;
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
  factory DirectusCollection.fromJson(Map<String, dynamic> json) =>
      _$DirectusCollectionFromJson(json);

  /// Used for code generation
  Map<String, dynamic> toJson() => _$DirectusCollectionToJson(this);
}

class CollectionConverter implements ItemsConverter<DirectusCollection> {
  @override
  Map<String, dynamic> toJson(data) => data.toJson();

  @override
  DirectusCollection fromJson(Map<String, dynamic> data) => DirectusCollection.fromJson(data);
}
