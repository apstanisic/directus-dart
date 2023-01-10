import 'package:directus_core/src/modules/collections/directus_collection.dart';
import 'package:test/test.dart';

void main() {
  test('DirectusCollection', () async {
    final collection = DirectusCollection.fromJson({'hidden': false});
    expect(collection, isA<DirectusCollection>());
    final collectionMap = collection.toJson();
    expect(collectionMap, isMap);
  });
}
