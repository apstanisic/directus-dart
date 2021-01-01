// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/directus_error.dart';
import 'package:directus/src/data_classes/directus_storage.dart';
import 'package:directus/src/utils/items_converter.dart';
import 'package:directus/src/utils/map_items_converter.dart';
import 'package:meta/meta.dart';

import 'handlers/handlers.dart';

class DirectusSdk {
  /// [Dio] client used for HTTP requests.
  @protected
  @visibleForTesting
  final Dio client;

  /// Storage used for persisting data.
  late final DirectusStorage _storage;

  /// Constructor with all provided services.
  DirectusSdk(String url, {required DirectusStorage storage, Dio? client})
      : _storage = storage,
        client = client ?? Dio(BaseOptions(baseUrl: url));

  /// Initialize SDK.
  Future<DirectusSdk> init() async {
    await auth.init();
    return this;
  }

  /// Get Directus API url
  String get url => client.options.baseUrl;

  /// Change Directus API url
  set url(String url) => client.options.baseUrl = url;

  /// Auth
  late AuthHandler auth = AuthHandler(client: client, storage: _storage);

  /// Items
  ItemsHandler<Map<String, dynamic>> items(String collection) {
    return typedItems(collection, converter: MapItemsConverter());
  }

  ItemsHandler<T> typedItems<T>(String collection, {required ItemsConverter<T> converter}) {
    if (collection.startsWith('directus')) {
      throw DirectusError(
        message: 'You can\t read $collection collection directly.',
        code: 1000,
      );
    }
    return ItemsHandler<T>(collection, client: client, converter: converter);
  }

  /// Activity
  ActivityHandler get activity {
    return ActivityHandler(client: client);
  }

  /// Collections
  CollectionsHandler get collections {
    return CollectionsHandler(client: client);
  }

  /// HTTP client that can be used for accessing custom extensions.
  Dio get custom => client;

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
