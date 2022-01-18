// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusCollection _$DirectusCollectionFromJson(Map<String, dynamic> json) =>
    DirectusCollection(
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
      translations: (json['translations'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      unarchiveValue: json['unarchive_value'] as String?,
    );

Map<String, dynamic> _$DirectusCollectionToJson(DirectusCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('collection', instance.collection);
  writeNotNull('icon', instance.icon);
  writeNotNull('note', instance.note);
  writeNotNull('display_template', instance.displayTemplate);
  writeNotNull('hidden', instance.hidden);
  writeNotNull('singleton', instance.singleton);
  writeNotNull('translations', instance.translations);
  writeNotNull('archive_field', instance.archiveField);
  writeNotNull('archive_app_filter', instance.archiveAppFilter);
  writeNotNull('archive_value', instance.archiveValue);
  writeNotNull('unarchive_value', instance.unarchiveValue);
  writeNotNull('sort_field', instance.sortField);
  return val;
}
