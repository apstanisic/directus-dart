// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_revision.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusRevision _$DirectusRevisionFromJson(Map<String, dynamic> json) {
  return DirectusRevision(
    id: json['id'] as int?,
    activity: json['activity'] as int?,
    collection: json['collection'] as String?,
    item: json['item'] as String?,
    data: json['data'] as Map<String, dynamic>?,
    delta: json['delta'] as Map<String, dynamic>?,
    parent: json['parent'] as int?,
  );
}

Map<String, dynamic> _$DirectusRevisionToJson(DirectusRevision instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activity': instance.activity,
      'collection': instance.collection,
      'item': instance.item,
      'data': instance.data,
      'delta': instance.delta,
      'parent': instance.parent,
    };
