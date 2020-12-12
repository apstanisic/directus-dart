import 'package:dio/dio.dart';
import 'package:directus/src/stores/directus_store.dart';
import 'package:directus/src/stores/store.dart';
import 'package:hive/hive.dart';
import 'handlers/handlers.dart';

class DirectusSDK {
  late Dio client;
  String _url;
  late DirectusStore store;

  DirectusSDK(this._url, {HiveStore? store}) {
    client = Dio(
      BaseOptions(baseUrl: _url),
    );
    this.store = store ?? HiveStore(Hive.box('directus'));
    auth = AuthHandler(client: client, store: this.store);
  }

  /// Get Directus API url
  String get url => _url;

  /// Change Directus API url
  set url(String url) {
    _url = url;
    client.options.baseUrl = url;
  }

  late AuthHandler auth;

  ItemsHandler items(String collection) {
    if (collection.startsWith('directus')) {
      throw Exception('You can\t read $collection collection directlly.');
    }
    return ItemsHandler(collection, client: client);
  }

  ActivityHandler get activity {
    return ActivityHandler(client: client);
  }

  CollectionsHandler get collections {
    return CollectionsHandler(client: client);
  }

  FieldsHandler get fields {
    return FieldsHandler(client: client);
  }

  FilesHandler get files {
    return FilesHandler(client: client);
  }

  FoldersHandler get folders {
    return FoldersHandler(client: client);
  }

  PermissionsHandler get permissions {
    return PermissionsHandler(client: client);
  }

  PresetsHandler get presets {
    return PresetsHandler(client: client);
  }

  RelationsHandler get relations {
    return RelationsHandler(client: client);
  }

  RevisionsHandler get revisions {
    return RevisionsHandler(client: client);
  }

  RolesHandler get roles {
    return RolesHandler(client: client);
  }

  ServerHandler get server {
    return ServerHandler(client: client);
  }

  SettingsHandler get settings {
    return SettingsHandler(client: client);
  }

  UsersHandler get users {
    return UsersHandler(client: client);
  }

  UtilsHandler get utils {
    return UtilsHandler(client: client);
  }
}
