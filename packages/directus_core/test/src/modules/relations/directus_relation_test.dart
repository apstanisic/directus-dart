import 'package:directus_core/src/modules/relations/directus_relation.dart';
import 'package:test/test.dart';

void main() {
  test('DirectusRelation', () async {
    final relation = DirectusRelation.fromJson({'id': 1});
    expect(relation, isA<DirectusRelation>());
    expect(relation.id, 1);
    final relationMap = relation.toJson();
    expect(relationMap, isMap);
  });
}
