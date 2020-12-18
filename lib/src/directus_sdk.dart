import 'package:dio/dio.dart';
import 'package:directus/src/collections/settings_item.dart';
import 'package:directus/src/data_classes/directus_item.dart';
import 'package:directus/src/stores/directus_store.dart';
import 'package:directus/src/stores/store.dart';

import 'handlers/handlers.dart';

class DirectusSDK {
  Dio client;
  late DirectusStore storage;
  final String _storagePath;

  DirectusSDK(String url, {required String storagePath, Dio? client})
      : client = client ?? Dio(BaseOptions(baseUrl: url)),
        _storagePath = storagePath;

  Future<DirectusSDK> init() async {
    final storage = await SembastStorage(path: _storagePath);
    await storage.init();
    auth = AuthHandler(client: client, storage: storage);
    return this;
  }

  /// Get Directus API url
  String get url => client.options.baseUrl;

  /// Change Directus API url
  set url(String url) => client.options.baseUrl = url;

  /// Auth
  late AuthHandler auth;

  /// Items
  ItemsHandler<T> items<T extends DirectusItem>(String collection,
      {CreateItem<T>? parse, T? convert}) {
    if (collection.startsWith('directus')) {
      throw Exception('You can\t read $collection collection directly.');
    }
    return ItemsHandler<T>(collection, client: client, convert: convert);
  }

  /// Activity
  ActivityHandler get activity {
    return ActivityHandler(client: client);
  }

  /// Collections
  CollectionsHandler get collections {
    return CollectionsHandler(client: client);
  }

  /// Fields
  FieldsHandler get fields {
    return FieldsHandler(client: client);
  }

  /// Files
  FilesHandler get files {
    return FilesHandler(client: client);
  }

  /// Folders
  FoldersHandler get folders {
    return FoldersHandler(client: client);
  }

  /// Permissions
  PermissionsHandler get permissions {
    return PermissionsHandler(client: client);
  }

  /// Presets
  PresetsHandler get presets {
    return PresetsHandler(client: client);
  }

  /// Relations
  RelationsHandler get relations {
    return RelationsHandler(client: client);
  }

  /// Revisions
  RevisionsHandler get revisions {
    return RevisionsHandler(client: client);
  }

  /// Roles
  RolesHandler get roles {
    return RolesHandler(client: client);
  }

  /// Server
  ServerHandler get server {
    return ServerHandler(client: client);
  }

  /// Settings
  SettingsHandler get settings {
    return SettingsHandler(client: client);
  }

  /// Users
  UsersHandler get users {
    return UsersHandler(client: client);
  }

  /// Utils
  UtilsHandler get utils {
    return UtilsHandler(client: client);
  }
}

class Test1 extends DirectusItem {
  @override
  Map toMap(data) {
    throw UnimplementedError();
  }

  @override
  Test1 fromMap() {
    throw UnimplementedError();
  }
}

class Test2 {}
