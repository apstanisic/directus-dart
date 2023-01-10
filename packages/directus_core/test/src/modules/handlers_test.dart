import 'package:directus_core/src/modules/handlers.dart';
import 'package:test/test.dart';

import '../mock/mocks.mocks.dart';

void main() {
  /// This does not test AuthHandler, that is special case
  test('that `handlers.dart` exports all handlers.', () async {
    final client = MockDio();

    ActivityHandler(client: client);
    CollectionsHandler(client: client);
    FieldsHandler(client: client);
    FilesHandler(client: client);
    FoldersHandler(client: client);
    ItemsHandler('test_collection', client: client);
    PermissionsHandler(client: client);
    PresetsHandler(client: client);
    RelationsHandler(client: client);
    RolesHandler(client: client);
    ServerHandler(client: client);
    SettingsHandler(client: client);
    UsersHandler(client: client);
    UtilsHandler(client: client);
  });
}
