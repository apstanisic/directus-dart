import 'package:dio/dio.dart';
import 'package:directus_core/src/modules/files/directus_file.dart';
import 'package:directus_core/src/modules/files/files_handler.dart';
import 'package:directus_core/src/modules/items/items_handler.dart';
import 'package:test/test.dart';

import '../../mock/mocks.mocks.dart';

void main() {
  late Dio client;
  late ItemsHandler<DirectusFile> handler;

  setUp(() {
    client = MockDio();
    handler = ItemsHandler('directus_files', client: client);
  });

  test('that FilesHandler has read and delete methods from ItemsHandler.',
      () async {
    final files = FilesHandler(client: MockDio());
    files.handler = handler;

    expect(files.updateOne, handler.updateOne);
    expect(files.readOne, handler.readOne);
    expect(files.readMany, handler.readMany);
    expect(files.deleteOne, handler.deleteOne);
    expect(files.deleteMany, handler.deleteMany);
  });
}
