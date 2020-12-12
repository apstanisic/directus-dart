import 'package:dio/dio.dart';

class ServerHandler {
  late Dio client;

  ServerHandler({required this.client});

  ping() async {
    await client.get('/server/ping');
    return 'pong';
  }

  info() async {
    final response = await client.get('/server/info');
    return response.data;
  }

  oas() async {
    final response = await client.get('/server/specs/oas');
    return response.data;
  }
}
