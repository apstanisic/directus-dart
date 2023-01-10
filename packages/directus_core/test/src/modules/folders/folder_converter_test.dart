import 'package:directus_core/src/modules/folders/directus_folder.dart';
import 'package:directus_core/src/modules/folders/folder_converter.dart';
import 'package:test/test.dart';

void main() {
  test('FolderConverter', () {
    final converter = FolderConverter();
    final folderMap = converter.toJson(DirectusFolder(id: 'fds'));
    expect(folderMap, isMap);
    final folder = converter.fromJson(folderMap);
    expect(folder, isA<DirectusFolder>());
  });
}
