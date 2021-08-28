import 'package:dio/dio.dart';
import 'package:directus/src/adapters/shared_preferences_storage.dart';
import 'package:directus/src/data_classes/directus_error.dart';
import 'package:directus/src/data_classes/directus_storage.dart';
import 'package:directus/src/modules/items/items_converter.dart';

import 'modules/handlers.dart';
import 'modules/items/map_items_converter.dart';

bool _isDirectusInitialized = false;

class Directus {
  /// [Dio] client used for HTTP requests.
  ///
  /// Client is visible so users can add more headers, or any other customization.
  final Dio client;

  /// Storage used for persisting data.
  final DirectusStorage _storage;

  /// Used for differentiating between multiple instances.
  final String? key;

  /// Constructor with all provided services.
  Directus(String url, {DirectusStorage? storage, Dio? client, this.key})
      : _storage = storage ?? SharedPreferencesStorage(),
        client = client ??
            Dio(BaseOptions(baseUrl: url.endsWith('/') ? url : '$url/')) {
    // Check if SDK is inited before first request.
    this
        .client
        .interceptors
        .add(InterceptorsWrapper(onRequest: _checkIfInited));
  }

  /// Add check to [Dio] to see if SDK is initialized before sending HTTP request.
  ///
  /// If [Directus] is initialized, this interceptor will be removed.
  void _checkIfInited(
      RequestOptions options, RequestInterceptorHandler handler) {
    if (!_isDirectusInitialized) {
      throw DirectusError(
          message: 'You must first call and await init method.');
    }

    client.interceptors.remove(_checkIfInited);
    return handler.next(options);
  }

  /// Initialize SDK.
  ///
  /// This method must be called before using any other method.
  ///
  /// It returns [Directus] object in which this method is called.
  /// This way simpla chaining is possible without using `..init()`.
  /// For example:
  /// ```dart
  /// sdk = await Directus(url).init();
  /// ```
  Future<Directus> init() async {
    await auth.init();
    _isDirectusInitialized = true;
    return this;
  }

  /// Get items from API with strong typings.
  ///
  /// [ItemsConverter] must be provided that will convert data to
  /// and from json. If you don't care about types, use [items],
  /// that will return [Map]. [converter] is a simple interface that converts value to
  /// and from JSON so it can be consumed with this API.
  ItemsHandler<T> typedItems<T>(String collection,
      {required ItemsConverter<T> converter}) {
    if (collection.startsWith('directus')) {
      throw DirectusError(
          message: 'You can\'t read $collection collection directly.');
    }
    return ItemsHandler<T>(collection, client: client, converter: converter);
  }

  /// Auth
  late final AuthHandler auth =
      AuthHandler(client: client, storage: _storage, refreshClient: Dio());

  /// Items
  ItemsHandler<Map<String, dynamic>> items(String collection) =>
      typedItems<Map<String, dynamic>>(collection,
          converter: MapItemsConverter());

  /// Activity
  ActivityHandler get activity => ActivityHandler(client: client);

  /// Collections
  CollectionsHandler get collections => CollectionsHandler(client: client);

  /// Use [client] instead. This is the same as client, only more descriptive name.
  ///
  /// HTTP client that can be used for accessing custom extensions.
  @Deprecated('Use this.client instead')
  Dio get custom => client;

  /// Fields
  FieldsHandler get fields => FieldsHandler(client: client);

  /// Files
  FilesHandler get files => FilesHandler(client: client);

  /// Folders
  FoldersHandler get folders => FoldersHandler(client: client);

  /// Permissions
  PermissionsHandler get permissions => PermissionsHandler(client: client);

  /// Presets
  PresetsHandler get presets => PresetsHandler(client: client);

  /// Relations
  RelationsHandler get relations => RelationsHandler(client: client);

  /// Revisions
  RevisionsHandler get revisions => RevisionsHandler(client: client);

  /// Roles
  RolesHandler get roles => RolesHandler(client: client);

  /// Server
  ServerHandler get server => ServerHandler(client: client);

  /// Settings
  SettingsHandler get settings => SettingsHandler(client: client);

  /// Users
  UsersHandler get users => UsersHandler(client: client);

  /// Utils
  UtilsHandler get utils => UtilsHandler(client: client);
}
