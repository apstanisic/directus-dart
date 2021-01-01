import 'package:directus/src/modules/collections/directus_collection.dart';
import 'package:test/test.dart';

void main() {
  test('DirectusCollection', () async {
    final collection = DirectusCollection.fromJson({'hidden': false});
    expect(collection, isA<DirectusCollection>());
    final collectionMap = collection.toJson();
    expect(collectionMap, isMap);
  });

  test('CollectionConverter', () {
    final converter = CollectionConverter();
    final collectionMap = converter.toJson(DirectusCollection(hidden: false));
    expect(collectionMap, isMap);
    final collection = converter.fromJson(collectionMap);
    expect(collection, isA<DirectusCollection>());
  });
}
