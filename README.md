# Direcuts SDK for Dart/Flutter

## Usage

```dart
import 'package:directus/directus.dart';

main() {
  final sdk = await Directus('http://localhost:8055').init();

  await sdk.auth.login(email: 'admin@example.com', password: 'password');

  final items = await sdk.items('posts').readMany(
        query: Query(
          filter: {
            'id': Filter.gte(4),
          },
        ),
      );
}
```
