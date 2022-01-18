// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_permission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusPermission _$DirectusPermissionFromJson(Map<String, dynamic> json) =>
    DirectusPermission(
      id: json['id'] as int?,
      role: json['role'] as String?,
      collection: json['collection'] as String?,
      action: json['action'] as String?,
      permissions: json['permissions'] as Map<String, dynamic>?,
      validation: json['validation'] as Map<String, dynamic>?,
      presets: json['presets'] as Map<String, dynamic>?,
      fields:
          (json['fields'] as List<dynamic>?)?.map((e) => e as String).toList(),
      limit: json['limit'] as int?,
    );

Map<String, dynamic> _$DirectusPermissionToJson(DirectusPermission instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('role', instance.role);
  writeNotNull('collection', instance.collection);
  writeNotNull('action', instance.action);
  writeNotNull('permissions', instance.permissions);
  writeNotNull('validation', instance.validation);
  writeNotNull('presets', instance.presets);
  writeNotNull('fields', instance.fields);
  writeNotNull('limit', instance.limit);
  return val;
}
