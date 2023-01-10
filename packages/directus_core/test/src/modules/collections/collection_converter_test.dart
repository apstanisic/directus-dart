import 'package:directus_core/src/modules/collections/collection_converter.dart';
import 'package:directus_core/src/modules/collections/directus_collection.dart';
import 'package:test/test.dart';

void main() {
  test('CollectionConverter', () {
    final converter = CollectionConverter();
    final collectionMap = converter.toJson(DirectusCollection(hidden: false));
    expect(collectionMap, isMap);
    final collection = converter.fromJson(collectionMap);
    expect(collection, isA<DirectusCollection>());
  });
}
