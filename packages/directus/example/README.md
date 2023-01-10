### directus

This package requires Flutter since it's using `shared_preferences` for persisting data.

```dart
import 'package:directus/directus.dart';

final sdk = await Directus('http://localhost:8055')
                    .init();
```
