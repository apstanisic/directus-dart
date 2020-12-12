import 'package:directus/directus.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    DirectusSDK sdk;

    setUp(() {
      sdk = DirectusSDK('http://example.com');
    });
  });
}
