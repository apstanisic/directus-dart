import 'package:directus/directus.dart';
import 'package:directus/src/directus_sdk.dart';
import 'package:test/test.dart';

import 'src/mock/mock_directus_storage.dart';

void main() {
  group('A group of tests', () {
    test('Directus returns sdk after init', () async {
      final directus = Directus('url', storage: MockDirectusStorage());
      expect(directus, isA<Directus>());
      final sdk = await directus.init();
      expect(sdk, isA<DirectusSdk>());
    });
  });
}
