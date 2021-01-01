// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_permission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusPermission _$DirectusPermissionFromJson(Map<String, dynamic> json) {
  return DirectusPermission(
    id: json['id'] as int?,
    role: json['role'] as String?,
    collection: json['collection'] as String?,
    action: json['action'] as String?,
    permissions: json['permissions'] as Map<String, dynamic>?,
    validation: json['validation'] as Map<String, dynamic>?,
    presets: json['presets'] as Map<String, dynamic>?,
    fields: json['fields'] as String?,
    limit: json['limit'] as int?,
  );
}

Map<String, dynamic> _$DirectusPermissionToJson(DirectusPermission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'collection': instance.collection,
      'action': instance.action,
      'permissions': instance.permissions,
      'validation': instance.validation,
      'presets': instance.presets,
      'fields': instance.fields,
      'limit': instance.limit,
    };
