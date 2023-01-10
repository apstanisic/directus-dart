// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_relation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusRelation _$DirectusRelationFromJson(Map<String, dynamic> json) =>
    DirectusRelation(
      id: json['id'] as int?,
      manyCollection: json['many_collection'] as String?,
      manyField: json['many_field'] as String?,
      manyPrimary: json['many_primary'] as String?,
      oneCollection: json['one_collection'] as String?,
      oneField: json['one_field'] as String?,
      onePrimary: json['one_primary'] as String?,
      oneCollectionField: json['one_collection_field'] as String?,
      oneAllowedCollections: json['one_allowed_collections'] as String?,
      junctionField: json['junction_field'] as String?,
    );

Map<String, dynamic> _$DirectusRelationToJson(DirectusRelation instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('many_collection', instance.manyCollection);
  writeNotNull('many_field', instance.manyField);
  writeNotNull('many_primary', instance.manyPrimary);
  writeNotNull('one_collection', instance.oneCollection);
  writeNotNull('one_field', instance.oneField);
  writeNotNull('one_primary', instance.onePrimary);
  writeNotNull('one_collection_field', instance.oneCollectionField);
  writeNotNull('one_allowed_collections', instance.oneAllowedCollections);
  writeNotNull('junction_field', instance.junctionField);
  return val;
}
