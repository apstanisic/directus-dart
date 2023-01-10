// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusActivity _$DirectusActivityFromJson(Map<String, dynamic> json) =>
    DirectusActivity(
      action: json['action'] as String?,
      collection: json['collection'] as String?,
      comment: json['comment'] as String?,
      id: json['id'] as int?,
      ip: json['ip'] as String?,
      item: json['item'],
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      user: json['user'],
      userAgent: json['user_agent'] as String?,
    );

Map<String, dynamic> _$DirectusActivityToJson(DirectusActivity instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('action', instance.action);
  writeNotNull('user', instance.user);
  writeNotNull('timestamp', instance.timestamp?.toIso8601String());
  writeNotNull('ip', instance.ip);
  writeNotNull('user_agent', instance.userAgent);
  writeNotNull('collection', instance.collection);
  writeNotNull('item', instance.item);
  writeNotNull('comment', instance.comment);
  return val;
}
