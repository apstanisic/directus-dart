### directus_core

This package does not require Flutter, but it does not know how to store data, so you have
to pass it your custom storage that extends `DirectusStorage`. We provide memory storage,
that holds your data in memory while app is live.

```dart
import 'package:directus_core/directus_core.dart';

// Provide your custom storage
final sdk = await DirectusCore('http://localhost:8055', storage: MemoryStorage())
                    .init();
```
