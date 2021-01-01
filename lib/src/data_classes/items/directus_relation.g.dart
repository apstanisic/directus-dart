// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_relation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusRelation _$DirectusRelationFromJson(Map<String, dynamic> json) {
  return DirectusRelation(
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
}

Map<String, dynamic> _$DirectusRelationToJson(DirectusRelation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'many_collection': instance.manyCollection,
      'many_field': instance.manyField,
      'many_primary': instance.manyPrimary,
      'one_collection': instance.oneCollection,
      'one_field': instance.oneField,
      'one_primary': instance.onePrimary,
      'one_collection_field': instance.oneCollectionField,
      'one_allowed_collections': instance.oneAllowedCollections,
      'junction_field': instance.junctionField,
    };
