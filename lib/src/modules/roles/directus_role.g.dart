// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusRole _$DirectusRoleFromJson(Map<String, dynamic> json) => DirectusRole(
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
      users:
          (json['users'] as List<dynamic>?)?.map((e) => e as Object).toList(),
    );

Map<String, dynamic> _$DirectusRoleToJson(DirectusRole instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('icon', instance.icon);
  writeNotNull('description', instance.description);
  writeNotNull('ip_access', instance.ipAccess);
  writeNotNull('enforce_tfa', instance.enforceTfa);
  writeNotNull('module_list', instance.moduleList);
  writeNotNull('collection_list', instance.collectionList);
  writeNotNull('admin_access', instance.adminAccess);
  writeNotNull('app_access', instance.appAccess);
  writeNotNull('users', instance.users);
  return val;
}
