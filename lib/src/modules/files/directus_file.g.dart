// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directus_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectusFile _$DirectusFileFromJson(Map<String, dynamic> json) {
  return DirectusFile(
    id: json['id'] as String?,
    storage: json['storage'] as String?,
    filenameDisk: json['filename_disk'] as String?,
    filenameDownload: json['filename_download'] as String?,
    title: json['title'] as String?,
    type: json['type'] as String?,
    folder: json['folder'],
    uploadedBy: json['uploaded_by'],
    uploadedOn: json['uploaded_on'] == null
        ? null
        : DateTime.parse(json['uploaded_on'] as String),
    modifiedBy: json['modified_by'],
    modifiedOn: json['modified_on'] == null
        ? null
        : DateTime.parse(json['modified_on'] as String),
    charset: json['charset'] as String?,
    filesize: json['filesize'] as int?,
    width: json['width'] as int?,
    height: json['height'] as int?,
    duration: json['duration'] as int?,
    embed: json['embed'] as String?,
    description: json['description'] as String?,
    location: json['location'] as String?,
    tags: json['tags'] as String?,
    metadata: json['metadata'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$DirectusFileToJson(DirectusFile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('storage', instance.storage);
  writeNotNull('filename_disk', instance.filenameDisk);
  writeNotNull('filename_download', instance.filenameDownload);
  writeNotNull('title', instance.title);
  writeNotNull('type', instance.type);
  writeNotNull('folder', instance.folder);
  writeNotNull('uploaded_by', instance.uploadedBy);
  writeNotNull('uploaded_on', instance.uploadedOn?.toIso8601String());
  writeNotNull('modified_by', instance.modifiedBy);
  writeNotNull('modified_on', instance.modifiedOn?.toIso8601String());
  writeNotNull('charset', instance.charset);
  writeNotNull('filesize', instance.filesize);
  writeNotNull('width', instance.width);
  writeNotNull('height', instance.height);
  writeNotNull('duration', instance.duration);
  writeNotNull('embed', instance.embed);
  writeNotNull('description', instance.description);
  writeNotNull('location', instance.location);
  writeNotNull('tags', instance.tags);
  writeNotNull('metadata', instance.metadata);
  return val;
}
