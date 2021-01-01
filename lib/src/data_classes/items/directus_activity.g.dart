// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusActivity _$DirectusActivityFromJson(Map<String, dynamic> json) {
  return DirectusActivity(
    action: json['action'] as String?,
    collection: json['collection'] as String?,
    comment: json['comment'] as String?,
    id: json['id'] as int?,
    ip: json['ip'] as String?,
    item: json['item'] as String?,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
    user: json['user'] as String?,
    userAgent: json['user_agent'] as String?,
  );
}

Map<String, dynamic> _$DirectusActivityToJson(DirectusActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action': instance.action,
      'user': instance.user,
      'timestamp': instance.timestamp?.toIso8601String(),
      'ip': instance.ip,
      'user_agent': instance.userAgent,
      'collection': instance.collection,
      'item': instance.item,
      'comment': instance.comment,
    };
