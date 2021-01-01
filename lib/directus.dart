/// Directus SDK that provides all needed APIs for using Directus server
///
/// It provides APIs for reading, creating, updating and deleting user and system data,
/// authentication, and access to activity.
///
/// ```dart
/// final sdk = await Directus('http://localhost:8055').init();
/// ```
library directus;

export 'src/data_classes/data_classes.dart';
export 'src/directus.dart';
