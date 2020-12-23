import 'package:directus/directus.dart';
import 'package:directus/src/directus_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    test('Directus returns sdk after init', () async {
      final directus = Directus('url');
      expect(directus, isA<Directus>());
      final sdk = await directus.init();
      expect(sdk, isA<DirectusSdk>());
    });
  });
}
