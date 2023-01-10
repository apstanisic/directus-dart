// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_preset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusPreset _$DirectusPresetFromJson(Map<String, dynamic> json) =>
    DirectusPreset(
      id: json['id'] as int?,
      bookmark: json['bookmark'] as String?,
      user: json['user'],
      role: json['role'],
      collection: json['collection'] as String?,
      search: json['search'] as String?,
      filters: (json['filters'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      layout: json['layout'] as String?,
      layoutQuery: json['layout_query'] as Map<String, dynamic>?,
      layoutOptions: json['layout_options'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$DirectusPresetToJson(DirectusPreset instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('bookmark', instance.bookmark);
  writeNotNull('user', instance.user);
  writeNotNull('role', instance.role);
  writeNotNull('collection', instance.collection);
  writeNotNull('search', instance.search);
  writeNotNull('filters', instance.filters);
  writeNotNull('layout', instance.layout);
  writeNotNull('layout_query', instance.layoutQuery);
  writeNotNull('layout_options', instance.layoutOptions);
  return val;
}
