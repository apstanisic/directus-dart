import 'package:dio/dio.dart';
import 'package:directus/src/handlers/items_handler.dart';

class UsersHandler extends ItemsHandler {
  UsersHandler({required Dio client}) : super('directus_users', client: client);

  Future<void> invite({required String email, required String roleId}) async {
    await client.post('/users/invite', data: {'email': email, 'role': roleId});
  }

  Future<void> inviteMany(
      {required List<String> emails, required String role}) async {
    await client.post('/users/invite', data: {'email': emails, 'role': role});
  }

  Future<void> acceptInvite(
      {required String token, required String password}) async {
    await client.post('/users/invite/accept',
        data: {'token': token, 'password': password});
  }
}
