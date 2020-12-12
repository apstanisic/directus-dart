# Direcuts SDK for Dart/Flutter

## Usage

```dart
import 'package:directus/directus.dart';

main() async {
  final sdk = DirectusSDK('http:example.com');
  await sdk.items('posts').readMany(query: Query(limit: 10));
}
```
