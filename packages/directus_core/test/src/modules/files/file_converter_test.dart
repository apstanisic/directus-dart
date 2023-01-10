import 'package:directus_core/src/modules/files/directus_file.dart';
import 'package:directus_core/src/modules/files/file_converter.dart';
import 'package:test/test.dart';

void main() {
  test('FileConverter', () {
    final converter = FileConverter();
    final fileMap =
        converter.toJson(DirectusFile(id: 'fds', description: 'Desc'));
    expect(fileMap, isMap);
    final file = converter.fromJson(fileMap);
    expect(file, isA<DirectusFile>());
  });
}
