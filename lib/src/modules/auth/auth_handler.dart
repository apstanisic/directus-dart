import 'dart:async';

import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/data_classes.dart';
import 'package:directus/src/modules/auth/_auth_refresh.dart';
import 'package:directus/src/modules/auth/_auth_storage.dart';
import 'package:directus/src/modules/auth/_current_user.dart';
import 'package:directus/src/modules/auth/_tfa.dart';
import 'package:directus/src/modules/auth/auth_delegate.dart';
import 'package:directus/src/modules/users/directus_user.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart' show BehaviorSubject;

import '_forgotten_password.dart';

class AuthHandler {
  AuthHandler({
    required Dio client,
    required Dio refreshClient,
    required DirectusStorage storage,
    AuthDelegate? authDelegate,
  })  : _client = client,
        _refreshClient = refreshClient,
        _storage = AuthStorage(storage),
        _authDelegate = authDelegate ?? DirectusAuthDelegate(),
        _userDataDelegate = CurrentUser(client: client),
        _userStreamController = BehaviorSubject<DirectusUser?>(),
        tfa = Tfa(client: client),
        forgottenPassword = ForgottenPassword(client: client) {
    // Setup Client
    _authDelegate.setupClient(client);
    // Refresh url is same as normal url.
    _refreshClient.options.baseUrl = client.options.baseUrl;
    // Get new access token if current is expired.
    client.interceptors.add(
      AuthRefresh(
        refreshClient: _refreshClient,
        storage: _storage,
        logoutCallback: _localLogout,
      ),
    );
  }

  /// Http client
  final Dio _client;

  /// Http client that is used to get new access token
  final Dio _refreshClient;

  final AuthDelegate _authDelegate;

  /// Storage used for storing data returned from login.
  final AuthStorage _storage;

  final StreamController<DirectusUser?> _userStreamController;

  DirectusUser? _currentUser;

  @internal
  set currentUser(DirectusUser? user) {
    _currentUser = user;
    _userStreamController.add(_currentUser);
  }

  DirectusUser? get currentUser => _currentUser;

  /// Stream for User
  Stream<DirectusUser?> get user => _userStreamController.stream;

  /// Manipulate current user.
  ///
  /// This value is [CurrentUser] when user is logged in, and [null] othervise.
  final CurrentUser _userDataDelegate;

  /// Enable and disable two factor authentication.
  ///
  /// This value is [Tfa] when user is logged in, and [null] othervise.
  final Tfa tfa;

  /// Class for requesting and setting forgotten password.
  final ForgottenPassword forgottenPassword;

  /// Initializes [AuthHandler], by getting data from cold storage.
  ///
  /// This method should be called right after constructor, othervise logged in user
  /// might appear as not logged in, because data isn't fetched from cold storage.
  Future<void> init() async {
    final tokens = await _storage.getLoginData();
    try {
      if (tokens != null) {
        await readUser();
      } else {
        currentUser = null;
      }
    } catch (_) {
      currentUser = null;
    }
  }

  /// Get current user
  Future<void> readUser() async {
    final response = await _userDataDelegate.read();
    currentUser = response.data;
  }

  /// Update current user
  Future<void> updateUser({
    required DirectusUser data,
  }) async {
    final response = await _userDataDelegate.update(data: data);
    currentUser = response.data;
  }

  /// Try to login user.
  Future<void> login(Map<String, Object?> data) async {
    try {
      final loginDataResponse = await _authDelegate.login(data);
      await _storage.storeLoginData(loginDataResponse);
      final response = await _userDataDelegate.read();
      currentUser = response.data;
    } catch (e) {
      throw DirectusError.fromDio(e);
    }
  }

  /// Try Logout user
  Future<void> logout() async {
    final tokens = await _storage.getLoginData();
    if (tokens == null) {
      throw DirectusError(message: 'User is not logged in.');
    }
    try {
      await _client.post(
        'auth/logout',
        data: {
          'refresh_token': tokens.refreshToken,
        },
      );
      await _localLogout();
    } catch (e) {
      throw DirectusError.fromDio(e);
    }
  }

  /// Logging out user locally
  Future<void> _localLogout() async {
    await _storage.removeLoginData();
    currentUser = null;
  }
}
