// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusRole _$DirectusRoleFromJson(Map<String, dynamic> json) {
  return DirectusRole(
    id: json['id'] as String?,
    name: json['name'] as String?,
    icon: json['icon'] as String?,
    description: json['description'] as String?,
    ipAccess: json['ip_access'] as String?,
    enforceTfa: json['enforce_tfa'] as bool?,
    moduleList: (json['module_list'] as List<dynamic>?)
        ?.map((e) => e as Map<String, dynamic>)
        .toList(),
    collectionList: (json['collection_list'] as List<dynamic>?)
        ?.map((e) => e as Map<String, dynamic>)
        .toList(),
    adminAccess: json['admin_access'] as bool?,
    appAccess: json['app_access'] as bool?,
  );
}

Map<String, dynamic> _$DirectusRoleToJson(DirectusRole instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'description': instance.description,
      'ip_access': instance.ipAccess,
      'enforce_tfa': instance.enforceTfa,
      'module_list': instance.moduleList,
      'collection_list': instance.collectionList,
      'admin_access': instance.adminAccess,
      'app_access': instance.appAccess,
    };
