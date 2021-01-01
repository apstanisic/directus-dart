import 'package:directus/src/modules/folders/directus_folder.dart';
import 'package:test/test.dart';

void main() {
  test('DirectusFolder', () async {
    final folder = DirectusFolder.fromJson({'id': 'some-id'});
    expect(folder, isA<DirectusFolder>());
    expect(folder.id, 'some-id');
    final folderMap = folder.toJson();
    expect(folderMap, isMap);
  });

  test('FolderConverter', () {
    final converter = FolderConverter();
    final folderMap = converter.toJson(DirectusFolder(id: 'fds'));
    expect(folderMap, isMap);
    final folder = converter.fromJson(folderMap);
    expect(folder, isA<DirectusFolder>());
  });
}
