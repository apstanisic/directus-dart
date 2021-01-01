// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusField _$DirectusFieldFromJson(Map<String, dynamic> json) {
  return DirectusField(
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
}

Map<String, dynamic> _$DirectusFieldToJson(DirectusField instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collection': instance.collection,
      'field': instance.field,
      'special': instance.special,
      'interface': instance.interface,
      'options': instance.options,
      'display': instance.display,
      'display_options': instance.displayOptions,
      'lock': instance.lock,
      'readonly': instance.readonly,
      'hidden': instance.hidden,
      'sort': instance.sort,
      'width': instance.width,
      'group': instance.group,
      'translations': instance.translations,
      'note': instance.note,
    };
