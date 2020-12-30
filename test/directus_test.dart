import 'package:directus/directus.dart';
import 'package:directus/src/directus_sdk.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'src/mock/mock_directus_storage.dart';

void main() {
  group('A group of tests', () {
    late DirectusStorage storage;
    setUp(() {
      storage = MockDirectusStorage();
    });

    test('that Directus returns DirectusSdk after initializing.', () async {
      final directus = Directus('url', storage: MockDirectusStorage());
      expect(directus, isA<Directus>());
      final sdk = await directus.init();
      expect(sdk, isA<DirectusSdk>());
    });

    test('that package will use provided storage instead of shared preferences.', () async {
      final directus = Directus('url', storage: storage);
      await directus.init();
      verify(storage.getItem(any as dynamic)).called(greaterThan(0));
    });

    // test('that user default storage will be used if user does not provide one.', () async {
    //   SharedPreferences.setMockInitialValues({});
    //   final sdk = await Directus('url').init();
    //   expect(sdk.storage, isA<DirectusStorage>());
    // });
  });
}
