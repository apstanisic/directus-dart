import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'directus_file.g.dart';

/// Fit of the thumbnail
///
/// The fit of the thumbnail while always preserving the aspect ratio,
/// can be any of the following options
enum DirectusThumbnailFit {
  /// Covers both width/height by cropping/clipping to fit
  cover,

  /// Contain within both width/height using "letterboxing" as needed
  contain,

  /// Resize to be as large as possible, ensuring dimensions are less
  /// than or equal to the requested width and height
  inside,

  /// Resize to be as small as possible, ensuring dimensions are greater
  /// than or equal to the requested width and height
  outside,
}

/// File format to return the thumbnail in
///
/// What file format to return the thumbnail in. One of jpg, png, webp, tiff
enum DirectusThumbnailFormat {
  jpg,
  png,
  webp,
  tiff,
}

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

  /// Return thumbnail url.
  ///
  /// This will return url from /.
  @experimental
  String? thumbnailUrl(
    String baseUrl, {
    required int width,
    required int height,
    DirectusThumbnailFit fit = DirectusThumbnailFit.cover,
    int? quality,
    DirectusThumbnailFormat? format,
  }) {
    if (id == null) return null;
    // Remove trailing / if exists.
    if (baseUrl.endsWith('/')) {
      baseUrl = baseUrl.substring(0, baseUrl.length - 1);
    }
    String url =
        '$baseUrl/assets/$id?fit=${fit.name}&width=$width&height=$height';
    if (quality != null) {
      assert(
        quality >= 1 && quality <= 100,
        'quality of the thumbnail should be from 1 to 100',
      );
      url += '&quality=$quality';
    }
    if (format != null) {
      url += '&format=${format.name}';
    }
    return url;
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
  int? width;
  int? height;
  int? duration;
  String? embed;
  String? description;
  String? location;
  String? tags;
  Map<String, Object?>? metadata;

  /// IDK Why but API returns string
  /// So I will simply make it an object for now
  /// Error: type 'String' is not a subtype of type 'int?' in type cast
  Object? filesize;

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
  factory DirectusFile.fromJson(Map<String, Object?> json) =>
      _$DirectusFileFromJson(json);

  /// Used for code generation
  Map<String, Object?> toJson() => _$DirectusFileToJson(this);
}
