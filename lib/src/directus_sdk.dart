import 'package:dio/dio.dart';
import 'package:directus/src/stores/directus_store.dart';
import 'package:directus/src/stores/store.dart';
import 'package:hive/hive.dart';
import 'handlers/handlers.dart';

class DirectusSDK {
  Dio client;
  DirectusStore store;

  DirectusSDK(String url, {DirectusStore? store})
      : client = Dio(BaseOptions(baseUrl: url)),
        store = store ?? HiveStore(Hive.box('directus')) {
    auth = AuthHandler(client: client, store: this.store);
  }

  /// Get Directus API url
  String get url => client.options.baseUrl;

  /// Change Directus API url
  set url(String url) => client.options.baseUrl = url;

  /// Auth
  late AuthHandler auth;

  /// Items
  ItemsHandler items(String collection) {
    if (collection.startsWith('directus')) {
      throw Exception('You can\t read $collection collection directly.');
    }
    return ItemsHandler(collection, client: client);
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
