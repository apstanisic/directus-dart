// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusFolder _$DirectusFolderFromJson(Map<String, dynamic> json) =>
    DirectusFolder(
      id: json['id'] as String?,
      name: json['name'] as String?,
      parent: json['parent'],
    );

Map<String, dynamic> _$DirectusFolderToJson(DirectusFolder instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('parent', instance.parent);
  return val;
}
