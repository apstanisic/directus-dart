import 'package:dio/dio.dart';
import 'package:directus_core/directus_core.dart';
import 'package:directus_core/src/modules/handlers.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'mock/mocks.mocks.dart';

void main() {
  group('DirectusCore', () {
    late Dio client;
    late DirectusCore sdk;
    late MockDirectusStorage storage;

    setUp(() async {
      client = MockDio();
      storage = MockDirectusStorage();
      when(client.interceptors).thenReturn(Interceptors());
      when(client.options).thenReturn(BaseOptions());
      when(storage.getItem(any)).thenAnswer((realInvocation) async => null);
      sdk = DirectusCore('url', client: client, storage: storage);
      await sdk.init();
    });

    test('that SDK is successfully created.', () async {
      expect(sdk, isA<DirectusCore>());
    });

    test('that client will be created if one isn\'t provided.', () {
      sdk = DirectusCore('url', storage: storage);
      expect(sdk.client, isA<Dio>());
    });

    test('that sdk will use provided client.', () {
      final newClient = MockDio();
      when(newClient.interceptors).thenReturn(Interceptors());
      when(newClient.options).thenReturn(BaseOptions());
      sdk = DirectusCore('url', storage: storage, client: newClient);
      expect(sdk.client, newClient);
    });

    test('that settings url sets base url for Dio.', () {
      final url = 'http://localhost:8055/';
      final sdk = DirectusCore(url, storage: storage);

      expect(sdk.client.options.baseUrl, url);
      // expect(sdk.url, url);
    });

    test('that settings url sets base url for Dio with trailing slash.', () {
      final url = 'http://localhost:8055';
      final sdk = DirectusCore(url, storage: storage);

      expect(sdk.client.options.baseUrl, '$url/');
      // expect(sdk.url, url);
    });

    // test('that url can be changed with setter.', () {
    //   final url = 'http://localhost:8055';
    //   final sdk = DirectusCore(url, storage: storage);

    //   final newUrl = 'http://example.com';
    //   // sdk.url = newUrl;
    //   expect(sdk.client.options.baseUrl, newUrl);
    //   expect(sdk.url, newUrl);
    // });

    test('that getters return correct handlers.', () {
      expect(sdk.activity, isA<ActivityHandler>());
      expect(sdk.collections, isA<CollectionsHandler>());
      expect(sdk.client, isA<Dio>());
      expect(sdk.fields, isA<FieldsHandler>());
      expect(sdk.files, isA<FilesHandler>());
      expect(sdk.folders, isA<FoldersHandler>());
      expect(sdk.items('collection'), isA<ItemsHandler>());
      expect(sdk.permissions, isA<PermissionsHandler>());
      expect(sdk.presets, isA<PresetsHandler>());
      expect(sdk.relations, isA<RelationsHandler>());
      expect(sdk.revisions, isA<RevisionsHandler>());
      expect(sdk.roles, isA<RolesHandler>());
      expect(sdk.server, isA<ServerHandler>());
      expect(sdk.settings, isA<SettingsHandler>());
      expect(sdk.users, isA<UsersHandler>());
      expect(sdk.utils, isA<UtilsHandler>());
    });

    test('that items throws if collection starts with `directus`.', () {
      expect(() => sdk.items('directus'), throwsException);
      expect(sdk.items('some_directus'), isA<ItemsHandler>());
    });
  });
}
