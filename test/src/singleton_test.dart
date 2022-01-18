import 'package:directus/directus.dart';
import 'package:test/test.dart';

void main() {
  final url = 'http://localhost:5000';
  test('Only one instance of singleton can exist', () async {
    await DirectusSingleton.initialize(url);
    final sdk1 = DirectusSingleton.instance;
    final sdk2 = DirectusSingleton.instance;

    expect(sdk1, sdk2);
  });

  test('Singleton must be initialized', () async {
    expect(() => DirectusSingleton.instance, throwsException);
    await DirectusSingleton.initialize(url);
    expect(DirectusSingleton.instance, isA<Directus>());
  });
}
