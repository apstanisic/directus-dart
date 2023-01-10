import 'package:directus_core/directus_core.dart';
import 'package:test/test.dart';

void main() {
  final url = 'http://localhost:5000';
  final storage = MemoryStorage();

  setUp(() {
    DirectusCoreSingleton.remove();
  });

  test('Only one instance of singleton can exist', () async {
    await DirectusCoreSingleton.init(url, storage: storage);
    final sdk1 = DirectusCoreSingleton.instance;
    final sdk2 = DirectusCoreSingleton.instance;

    expect(sdk1, sdk2);
  });

  test('Singleton must be initialized', () async {
    expect(() => DirectusCoreSingleton.instance, throwsException);
    await DirectusCoreSingleton.init(url, storage: storage);
    expect(DirectusCoreSingleton.instance, isA<DirectusCore>());
  });

  test('Singleton can be inited only once', () async {
    await DirectusCoreSingleton.init(url, storage: storage);
    final sdk1 = DirectusCoreSingleton.instance;
    await DirectusCoreSingleton.init(url, storage: storage);
    final sdk2 = DirectusCoreSingleton.instance;

    expect(sdk1, sdk2);
  });
}
