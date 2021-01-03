// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/data_classes.dart';
import 'package:directus/src/modules/items/items_handler.dart';
import 'package:directus/src/modules/users/user_converter.dart';

import 'directus_user.dart';

class UsersHandler extends ItemsHandler<DirectusUser> {
  UsersHandler({required Dio client})
      : super(
          'directus_users',
          client: client,
          converter: UserConverter(),
        );

  Future<void> invite({required String email, required String roleId}) async {
    try {
      await client.post('users/invite', data: {'email': email, 'role': roleId});
    } catch (e) {
      throw DirectusError.fromDio(e);
    }
  }

  Future<void> inviteMany({required List<String> emails, required String role}) async {
    try {
      await client.post('users/invite', data: {'email': emails, 'role': role});
    } catch (e) {
      throw DirectusError.fromDio(e);
    }
  }

  Future<void> acceptInvite({required String token, required String password}) async {
    try {
      await client.post('users/invite/accept', data: {'token': token, 'password': password});
    } catch (e) {
      throw DirectusError.fromDio(e);
    }
  }
}
