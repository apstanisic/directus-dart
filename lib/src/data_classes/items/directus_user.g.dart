// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusUser _$DirectusUserFromJson(Map<String, dynamic> json) {
  return DirectusUser(
    id: json['id'] as String?,
    firstName: json['first_name'] as String?,
    lastName: json['last_name'] as String?,
    email: json['email'] as String?,
    password: json['password'] as String?,
    location: json['location'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    avatar: json['avatar'] as String?,
    language: json['language'] as String?,
    theme: json['theme'] as String?,
    status: json['status'] as String?,
    role: json['role'] as String?,
  );
}

Map<String, dynamic> _$DirectusUserToJson(DirectusUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'location': instance.location,
      'title': instance.title,
      'description': instance.description,
      'tags': instance.tags,
      'avatar': instance.avatar,
      'language': instance.language,
      'theme': instance.theme,
      'status': instance.status,
      'role': instance.role,
    };
