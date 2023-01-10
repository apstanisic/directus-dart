// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_revision.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusRevision _$DirectusRevisionFromJson(Map<String, dynamic> json) =>
    DirectusRevision(
      id: json['id'] as int?,
      activity: json['activity'],
      collection: json['collection'] as String?,
      item: json['item'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      delta: json['delta'] as Map<String, dynamic>?,
      parent: json['parent'],
    );

Map<String, dynamic> _$DirectusRevisionToJson(DirectusRevision instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('activity', instance.activity);
  writeNotNull('collection', instance.collection);
  writeNotNull('item', instance.item);
  writeNotNull('data', instance.data);
  writeNotNull('delta', instance.delta);
  writeNotNull('parent', instance.parent);
  return val;
}
