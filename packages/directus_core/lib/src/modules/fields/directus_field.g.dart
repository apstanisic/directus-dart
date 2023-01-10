// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusField _$DirectusFieldFromJson(Map<String, dynamic> json) =>
    DirectusField(
      id: json['id'] as int?,
      collection: json['collection'] as String?,
      field: json['field'] as String?,
      special: json['special'] as String?,
      interface: json['interface'] as String?,
      options: json['options'] as Map<String, dynamic>?,
      display: json['display'] as String?,
      displayOptions: json['display_options'] as Map<String, dynamic>?,
      lock: json['lock'] as bool?,
      readonly: json['readonly'] as bool?,
      hidden: json['hidden'] as bool?,
      sort: json['sort'] as int?,
      width: json['width'] as String?,
      group: json['group'] as int?,
      translations: (json['translations'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$DirectusFieldToJson(DirectusField instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('collection', instance.collection);
  writeNotNull('field', instance.field);
  writeNotNull('special', instance.special);
  writeNotNull('interface', instance.interface);
  writeNotNull('options', instance.options);
  writeNotNull('display', instance.display);
  writeNotNull('display_options', instance.displayOptions);
  writeNotNull('lock', instance.lock);
  writeNotNull('readonly', instance.readonly);
  writeNotNull('hidden', instance.hidden);
  writeNotNull('sort', instance.sort);
  writeNotNull('width', instance.width);
  writeNotNull('group', instance.group);
  writeNotNull('translations', instance.translations);
  writeNotNull('note', instance.note);
  return val;
}
