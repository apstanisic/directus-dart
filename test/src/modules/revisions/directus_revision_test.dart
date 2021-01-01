import 'package:directus/src/modules/revisions/directus_revision.dart';
import 'package:test/test.dart';

void main() {
  test('DirectusRevision', () async {
    final revision = DirectusRevision.fromJson({'id': 1});
    expect(revision, isA<DirectusRevision>());
    expect(revision.id, 1);
    final revisionMap = revision.toJson();
    expect(revisionMap, isMap);
  });

  test('RevisionConverter', () {
    final converter = RevisionConverter();
    final revisionMap = converter.toJson(DirectusRevision(id: 1));
    expect(revisionMap, isMap);
    final revision = converter.fromJson(revisionMap);
    expect(revision, isA<DirectusRevision>());
  });
}
