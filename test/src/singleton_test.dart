import 'package:directus/directus.dart';
import 'package:test/test.dart';

void main() {
  final url = 'http://localhost:5000';
  test('Only one instance of singleton can exist', () async {
    await DirectusSingleton.init(url);
    final sdk1 = DirectusSingleton.instance;
    final sdk2 = DirectusSingleton.instance;

    expect(sdk1, sdk2);
  });

  test('Singleton must be initialized', () async {
    expect(() => DirectusSingleton.instance, throwsException);
    await DirectusSingleton.init(url);
    expect(DirectusSingleton.instance, isA<Directus>());
  });

  test('Singleton can be inited only once', () async {
    await DirectusSingleton.init(url);
    final sdk1 = DirectusSingleton.instance;
    await DirectusSingleton.init(url);
    final sdk2 = DirectusSingleton.instance;

    expect(sdk1, sdk2);
  });
}
