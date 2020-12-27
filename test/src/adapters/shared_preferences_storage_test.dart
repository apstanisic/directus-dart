import 'package:directus/src/adapters/shared_preferences_storage.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  group('SharedPreferencesStorage', () {
    late SharedPreferencesStorage storage;

    setUp(() async {
      SharedPreferences.setMockInitialValues({
        'stringValue': 'value',
        'intValue': 5,
      });
      SharedPreferences instance = await SharedPreferences.getInstance();

      storage = SharedPreferencesStorage(instance);
    });

    test('that `getItem` works.', () async {
      final stringValue = await storage.getItem('stringValue');
      expect(stringValue, 'value');

      final intValue = await storage.getItem('intValue');
      expect(intValue, 5);
    });

    test('that `setItem` works.', () async {
      await storage.setItem('newValue', 'value');
      var newValue = await storage.getItem('newValue');
      expect(newValue, 'value');

      await storage.setItem('newValue', 5);
      newValue = await storage.getItem('newValue');
      expect(newValue, 5);

      await storage.setItem('newValue', 5.5);
      newValue = await storage.getItem('newValue');
      expect(newValue, 5.5);

      await storage.setItem('newValue', true);
      newValue = await storage.getItem('newValue');
      expect(newValue, true);
    });

    test('that `setItem` throws if invalid type is paassed as value', () {
      expect(() => storage.setItem('key', []), throwsException);
    });
  });
}
