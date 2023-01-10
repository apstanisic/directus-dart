import 'package:directus_core/src/modules/relations/directus_relation.dart';
import 'package:directus_core/src/modules/relations/relation_converter.dart';
import 'package:test/test.dart';

void main() {
  test('RelationConverter', () {
    final converter = RelationConverter();
    final relationMap = converter.toJson(DirectusRelation(id: 1));
    expect(relationMap, isMap);
    final relation = converter.fromJson(relationMap);
    expect(relation, isA<DirectusRelation>());
  });
}
