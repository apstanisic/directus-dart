import 'package:directus/src/modules/files/directus_file.dart';
import 'package:test/test.dart';

void main() {
  test('DirectusFile', () async {
    final file = DirectusFile.fromJson({'id': 'some-id'});
    expect(file, isA<DirectusFile>());
    expect(file.id, 'some-id');
    final fileMap = file.toJson();
    expect(fileMap, isMap);
  });

  test('FileConverter', () {
    final converter = FileConverter();
    final fileMap = converter.toJson(DirectusFile(id: 'fds', description: 'Desc'));
    expect(fileMap, isMap);
    final file = converter.fromJson(fileMap);
    expect(file, isA<DirectusFile>());
  });
}
