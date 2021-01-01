// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusCollection _$DirectusCollectionFromJson(Map<String, dynamic> json) {
  return DirectusCollection(
    archiveAppFilter: json['archive_app_filter'] as bool?,
    archiveField: json['archive_field'] as String?,
    archiveValue: json['archive_value'] as String?,
    collection: json['collection'] as String?,
    displayTemplate: json['display_template'] as String?,
    hidden: json['hidden'] as bool?,
    icon: json['icon'] as String?,
    note: json['note'] as String?,
    singleton: json['singleton'] as bool?,
    sortField: json['sort_field'] as String?,
    translations: json['translations'] as Map<String, dynamic>?,
    unarchiveValue: json['unarchive_value'] as String?,
  );
}

Map<String, dynamic> _$DirectusCollectionToJson(DirectusCollection instance) =>
    <String, dynamic>{
      'collection': instance.collection,
      'icon': instance.icon,
      'note': instance.note,
      'display_template': instance.displayTemplate,
      'hidden': instance.hidden,
      'singleton': instance.singleton,
      'translations': instance.translations,
      'archive_field': instance.archiveField,
      'archive_app_filter': instance.archiveAppFilter,
      'archive_value': instance.archiveValue,
      'unarchive_value': instance.unarchiveValue,
      'sort_field': instance.sortField,
    };
