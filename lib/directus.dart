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
export 'src/data_classes/data_classes.dart';
export 'src/directus.dart';
export 'src/directus.dart';
export 'src/modules/activity/directus_activity.dart';
export 'src/modules/collections/directus_collection.dart';
export 'src/modules/fields/directus_field.dart';
export 'src/modules/files/directus_file.dart';
export 'src/modules/folders/directus_folder.dart';
export 'src/modules/permissions/directus_permission.dart';
export 'src/modules/presets/directus_preset.dart';
export 'src/modules/relations/directus_relation.dart';
export 'src/modules/revisions/directus_revision.dart';
export 'src/modules/roles/directus_role.dart';
export 'src/modules/settings/directus_settings.dart';
export 'src/modules/users/directus_user.dart';
