import 'package:directus/src/shared_preferences_storage.dart';
import 'package:directus_core/directus_core.dart';

class Directus extends DirectusCore {
  Directus(
    super.url, {
    super.client,
    super.key,
    DirectusStorage? storage,
  }) : super(storage: storage ?? SharedPreferencesStorage());
}
