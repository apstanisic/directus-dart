import 'package:dio/dio.dart';

import '../../directus.dart';

class ServerHandler {
  Dio client;

  ServerHandler({required this.client});

  Future<String> ping() async {
    await client.get('/server/ping');
    return 'pong';
  }

  Future<DirectusResponse<Map>> info() async {
    final response = await client.get('/server/info');
    return DirectusResponse(response);
  }

  Future<DirectusResponse<Map>> oas() async {
    final response = await client.get('/server/specs/oas');
    return DirectusResponse(response);
  }
}
