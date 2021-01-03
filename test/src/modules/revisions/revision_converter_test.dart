import 'package:directus/src/modules/revisions/directus_revision.dart';
import 'package:directus/src/modules/revisions/revision_converter.dart';
import 'package:test/test.dart';

void main() {
  test('RevisionConverter', () {
    final converter = RevisionConverter();
    final revisionMap = converter.toJson(DirectusRevision(id: 1));
    expect(revisionMap, isMap);
    final revision = converter.fromJson(revisionMap);
    expect(revision, isA<DirectusRevision>());
  });
}
