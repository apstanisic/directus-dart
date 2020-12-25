import 'package:dio/dio.dart';
import 'package:directus/src/directus_sdk.dart';
import 'package:directus/src/handlers/handlers.dart';
import 'package:directus/src/data_classes/directus_storage.dart';
import 'package:test/test.dart';

import 'mock/mock_dio.dart';
import 'mock/mock_directus_storage.dart';

void main() {
  group('DirectusSDK', () {
    late Dio client;
    late DirectusSdk sdk;
    late DirectusStorage storage;

    setUp(() async {
      client = MockDio();
      storage = MockDirectusStorage();
      sdk = DirectusSdk('url', client: client, storage: storage);
      await sdk.init();
    });
    test('SDK is succesfully created.', () async {
      expect(sdk.url, '');
    });

    test('Create Dio client if only url is passed.', () {
      final newClient = MockDio();
      sdk = DirectusSdk('url', storage: storage);
      expect(sdk.client, isA<Dio>());

      sdk = DirectusSdk('url', storage: storage, client: newClient);
      expect(sdk.client, newClient);
    });

    test('Set url as base url in client.', () {
      final url = 'http://localhost:8055';
      final sdk = DirectusSdk(url, storage: storage);

      expect(sdk.client.options.baseUrl, url);
    });

    test('Change url with setter.', () {
      final url = 'http://localhost:8055';
      final sdk = DirectusSdk(url, storage: storage);
      expect(sdk.client.options.baseUrl, url);

      final newUrl = 'http://example.com';
      sdk.url = newUrl;
      expect(sdk.client.options.baseUrl, newUrl);
    });

    test('Throws error if sdk is not initialized before using auth', () {});

    test('Getters return correct handler', () {
      expect(sdk.activity, isA<ActivityHandler>());
      expect(sdk.collections, isA<CollectionsHandler>());
      expect(sdk.custom, isA<Dio>());
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

    test('items throws if collection starts with directus', () {
      expect(() => sdk.items('directus'), throwsException);
      expect(sdk.items('some_directus'), isA<ItemsHandler>());
    });
  });
}
