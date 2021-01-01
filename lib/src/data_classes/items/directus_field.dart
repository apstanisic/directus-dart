import 'package:directus/src/utils/items_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'directus_field.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DirectusField {
  int? id;
  String? collection;
  String? field;
  String? special;
  String? interface;
  Map<String, dynamic>? options;
  String? display;
  Map<String, dynamic>? displayOptions;
  bool? lock;
  bool? readonly;
  bool? hidden;
  int? sort;
  String? width;
  int? group;
  List<Map<String, dynamic>>? translations;
  String? note;

  DirectusField({
    this.id,
    this.collection,
    this.field,
    this.special,
    this.interface,
    this.options,
    this.display,
    this.displayOptions,
    this.lock,
    this.readonly,
    this.hidden,
    this.sort,
    this.width,
    this.group,
    this.translations,
    this.note,
  });

  /// Used for code generation
  factory DirectusField.fromJson(Map<String, dynamic> json) => _$DirectusFieldFromJson(json);

  /// Used for code generation
  Map<String, dynamic> toJson() => _$DirectusFieldToJson(this);
}

class FieldConverter implements ItemsConverter<DirectusField> {
  @override
  Map<String, dynamic> toJson(data) {
    return data.toJson();
  }

  @override
  DirectusField fromJson(Map<String, dynamic> data) {
    return DirectusField.fromJson(data);
  }
}
