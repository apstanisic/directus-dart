// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusFolder _$DirectusFolderFromJson(Map<String, dynamic> json) {
  return DirectusFolder(
    id: json['id'] as String?,
    name: json['name'] as String?,
    parent: json['parent'] as String?,
  );
}

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
