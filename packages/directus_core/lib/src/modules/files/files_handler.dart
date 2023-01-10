import 'package:dio/dio.dart';
import 'package:directus_core/src/data_classes/data_classes.dart';
import 'package:directus_core/src/modules/items/items_handler.dart';
import 'package:meta/meta.dart';

import 'directus_file.dart';
import 'file_converter.dart';

/// Handle all needed functionality for files.
///
/// FilesHandler does not have all methods of [ItemsHandler].
/// It can change file, or create new file normally.
/// That's why it uses only methods for read and delete,
/// there is no update methods, and have special methods for file upload.
class FilesHandler {
  /// Handler that is used for shared method between files and items.
  @visibleForTesting
  ItemsHandler<DirectusFile> handler;

  /// HTTP Client.
  final Dio client;

  /// Constructor that sets up [handler].
  FilesHandler({required this.client})
      : handler = ItemsHandler(
          'directus_files',
          client: client,
          converter: FileConverter(),
        );

  /// Update one file, same method as in [ItemsHandler.updateOne].
  late final updateOne = handler.updateOne;

  /// Get one file, same method as in [ItemsHandler.readOne].
  late final readOne = handler.readOne;

  /// Get many files, same method as in [ItemsHandler.readMany].
  late final readMany = handler.readMany;

  /// Delete one file, same method as in [ItemsHandler.deleteOne].
  late final deleteOne = handler.deleteOne;

  /// Delete many files, same method as in [ItemsHandler.deleteMany].
  late final deleteMany = handler.deleteMany;

  /// Upload file.
  ///
  /// There is no method for uploading multiple files at the same time.
  @experimental
  Future<Future<DirectusResponse<DirectusFile>>> uploadFile(String path) async {
    final fileName = path.split('/').last;

    final data = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        path,
        filename: fileName,
      )
    });

    return DirectusResponse.fromRequest<DirectusFile>(
      () => client.post('files', data: data),
      converter: FileConverter(),
    );
  }
}
