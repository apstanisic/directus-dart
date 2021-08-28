import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'directus_file.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DirectusFile {
  /// Return root url.
  ///
  /// This will return url from /.
  /// There is no way that [DirectusFile] can know [baseUrl], so user must provide it manually,
  /// at least for now.
  /// This method is experimental because I don't like the API, it should be simple getter,
  /// without needing to pass [baseUrl], but It's not possible right now. One solution is to
  /// make [FileConverter] do that, but that is complicating a codebase, for a little gain,
  /// this way all converters and classes are same.
  @experimental
  String? downloadUrl(String baseUrl) {
    if (id == null) return null;
    // Remove trailing / if exists.
    if (baseUrl.endsWith('/')) {
      baseUrl = baseUrl.substring(0, baseUrl.length - 1);
    }

    return '$baseUrl/assets/$id';
  }

  String? id;
  String? storage;
  String? filenameDisk;
  String? filenameDownload;
  String? title;
  String? type;

  /// Folder. Either [String] or [DirectusFolder].
  Object? folder;

  /// Either [String] or [DirectusUser].
  Object? uploadedBy;
  DateTime? uploadedOn;

  /// Either [String] or [DirectusUser].
  Object? modifiedBy;
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
  factory DirectusFile.fromJson(Map<String, dynamic> json) =>
      _$DirectusFileFromJson(json);

  /// Used for code generation
  Map<String, dynamic> toJson() => _$DirectusFileToJson(this);
}
