import 'package:directus/src/modules/handlers.dart';
import 'package:directus/src/modules/utils_handler.dart';
import 'package:test/test.dart';

import '../mock/mock_dio.dart';
import '../mock/mock_directus_storage.dart';

void main() {
  test('that `handlers.dart` exports all handlers.', () async {
    final client = MockDio();
    final storage = MockDirectusStorage();
    final refreshClient = MockDio();

    ActivityHandler(client: client);
    AuthHandler(client: client, storage: storage, refreshClient: refreshClient);
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
