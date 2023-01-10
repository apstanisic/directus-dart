/// Directus SDK that provides all needed APIs for using Directus server
///
/// It provides APIs for reading, creating, updating and deleting user and system data,
/// authentication, and access to activity.
///
/// ```dart
/// final sdk = await Directus('http://localhost:8055').init();
/// ```
library directus;

export 'package:directus_core/directus_core.dart';

export './src/directus_base.dart';
export './src/shared_preferences_storage.dart';
