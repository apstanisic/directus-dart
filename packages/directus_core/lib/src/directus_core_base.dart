import 'package:dio/dio.dart';
import 'package:directus_core/src/data_classes/directus_error.dart';
import 'package:directus_core/src/data_classes/directus_storage.dart';
import 'package:directus_core/src/modules/items/items_converter.dart';

import 'modules/handlers.dart';
import 'modules/items/map_items_converter.dart';

class DirectusCore {
  bool _isInitialized = false;

  /// [Dio] client used for HTTP requests.
  ///
  /// Client is visible so users can add more headers, or any other customization.
  final Dio client;

  /// Storage used for persisting data.
  final DirectusStorage _storage;

  /// Used for differentiating between multiple instances.
  final String? key;

  /// Constructor with all provided services.
  DirectusCore(String url,
      {required DirectusStorage storage, Dio? client, this.key})
      : _storage = storage,
        client = client ??
            Dio(
              BaseOptions(baseUrl: url.endsWith('/') ? url : '$url/'),
            ) {
    // Check if SDK is inited before first request.
    _ensureSdkInitialized();
  }

  /// Add check to [Dio] to see if SDK is initialized before sending HTTP request.
  ///
  /// If [DirectusCore] is initialized, this interceptor will be removed.
  /// TODO Clean way to remove interceptor after initialization
  void _ensureSdkInitialized() {
    final check = InterceptorsWrapper(
      onRequest: (options, handler) {
        if (!_isInitialized) {
          return handler.reject(DioError(
              type: DioErrorType.other,
              requestOptions: options,
              error: DirectusError(
                message: 'You must first call and await init method.',
              )));
        }
        return handler.next(options);
      },
    );
    client.interceptors.add(check);
  }

  /// Initialize SDK.
  ///
  /// This method must be called before using any other method.
  ///
  /// It returns [DirectusCore] object in which this method is called.
  /// This way simply chaining is possible without using `..init()`.
  /// For example:
  /// ```dart
  /// sdk = await Directus(url).init();
  /// ```
  Future<DirectusCore> init() async {
    if (_isInitialized) return this;

    await auth.init();
    _isInitialized = true;

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
          message: "You can't read $collection collection directly.");
    }
    return ItemsHandler<T>(collection, client: client, converter: converter);
  }

  /// Items
  ItemsHandler<Map<String, dynamic>> items(String collection) {
    return typedItems<Map<String, dynamic>>(
      collection,
      converter: MapItemsConverter(),
    );
  }

  /// Auth
  late final AuthHandler auth =
      AuthHandler(client: client, storage: _storage, refreshClient: Dio());

  /// Activity
  late final ActivityHandler activity = ActivityHandler(client: client);

  /// Collections
  late final CollectionsHandler collections =
      CollectionsHandler(client: client);

  /// Fields
  late final FieldsHandler fields = FieldsHandler(client: client);

  /// Files
  late final FilesHandler files = FilesHandler(client: client);

  /// Folders
  late final FoldersHandler folders = FoldersHandler(client: client);

  /// Permissions
  late final PermissionsHandler permissions =
      PermissionsHandler(client: client);

  /// Presets
  late final PresetsHandler presets = PresetsHandler(client: client);

  /// Relations
  late final RelationsHandler relations = RelationsHandler(client: client);

  /// Revisions
  late final RevisionsHandler revisions = RevisionsHandler(client: client);

  /// Roles
  late final RolesHandler roles = RolesHandler(client: client);

  /// Server
  late final ServerHandler server = ServerHandler(client: client);

  /// Settings
  late final SettingsHandler settings = SettingsHandler(client: client);

  /// Users
  late final UsersHandler users = UsersHandler(client: client);

  /// Utils
  late final UtilsHandler utils = UtilsHandler(client: client);

  /// Use [client] instead. This is the same as client, only more descriptive name.
  ///
  /// HTTP client that can be used for accessing custom extensions.
  @Deprecated('Use this.client instead')
  Dio get custom => client;
}
