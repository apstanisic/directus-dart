import 'package:dio/dio.dart';
import 'package:directus/src/handlers/items_handler.dart';
import 'package:directus/src/query/query.dart';

class UsersHandler extends ItemsHandler {
  UsersHandler({required Dio client}) : super('directus_users', client: client);

  invite({required String email, required String role}) async {
    await client.post('/users/invite', data: {'email': email, 'role': role});
  }

  inviteMany({required List<String> emails, required String role}) async {
    await client.post('/users/invite', data: {'email': emails, 'role': role});
  }

  acceptInvite({required String token, required String password}) async {
    await client.post('/users/invite/accept', data: {'token': token, 'password': password});
  }

  enableTfa(String password) async {
    await client.post('/users/tfa/enable', data: {'password': password});
  }

  disableTfa(String otp) async {
    await client.post('/users/tfa/disable', data: {'otp': otp});
  }

  readMe({Query? query}) async {
    final response = await client.get('/users/me', queryParameters: query?.toMap());
    return response.data;
  }

  updateMe({required Map data, Query? query}) async {
    final response = await client.patch('/users/me', data: data, queryParameters: query?.toMap());
    return response.data;
  }
}
