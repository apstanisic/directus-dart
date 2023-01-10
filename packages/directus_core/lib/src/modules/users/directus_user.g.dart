// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusUser _$DirectusUserFromJson(Map<String, dynamic> json) => DirectusUser(
      id: json['id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      location: json['location'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      avatar: json['avatar'],
      language: json['language'] as String?,
      theme: json['theme'] as String?,
      status: json['status'] as String?,
      role: json['role'],
    );

Map<String, dynamic> _$DirectusUserToJson(DirectusUser instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('email', instance.email);
  writeNotNull('password', instance.password);
  writeNotNull('location', instance.location);
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('tags', instance.tags);
  writeNotNull('avatar', instance.avatar);
  writeNotNull('language', instance.language);
  writeNotNull('theme', instance.theme);
  writeNotNull('status', instance.status);
  writeNotNull('role', instance.role);
  return val;
}
