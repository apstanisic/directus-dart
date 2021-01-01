import 'package:directus/src/modules/items/items_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'directus_file.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DirectusFile {
  String? id;
  String? storage;
  String? filenameDisk;
  String? filenameDownload;
  String? title;
  String? type;
  String? folder;
  String? uploadedBy;
  DateTime? uploadedOn;
  String? modifiedBy;
  DateTime? modifiedOn;
  String? charset;
  int? filesize;
  int? width;
  int? height;
  int? duration;
  String? embed;
  String? description;
  String? location;
  String? tags;
  Map<String, dynamic>? metadata;

  DirectusFile({
    this.id,
    this.storage,
    this.filenameDisk,
    this.filenameDownload,
    this.title,
    this.type,
    this.folder,
    this.uploadedBy,
    this.uploadedOn,
    this.modifiedBy,
    this.modifiedOn,
    this.charset,
    this.filesize,
    this.width,
    this.height,
    this.duration,
    this.embed,
    this.description,
    this.location,
    this.tags,
    this.metadata,
  });

  /// Used for code generation
  factory DirectusFile.fromJson(Map<String, dynamic> json) => _$DirectusFileFromJson(json);

  /// Used for code generation
  Map<String, dynamic> toJson() => _$DirectusFileToJson(this);
}

class FileConverter implements ItemsConverter<DirectusFile> {
  @override
  Map<String, dynamic> toJson(data) => data.toJson();

  @override
  DirectusFile fromJson(Map<String, dynamic> data) => DirectusFile.fromJson(data);
}
