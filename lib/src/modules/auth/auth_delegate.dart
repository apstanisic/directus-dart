import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '_auth_response.dart';

abstract class AuthDelegate {
  AuthDelegate();

  Dio? _client;

  Dio get client {
    if (_client == null) {
      throw Exception('Missing client, call setupClient');
    } else {
      return _client!;
    }
  }

  @mustCallSuper
  void setupClient(Dio client) {
    _client = client;
  }

  /// Call to receive [AuthResponse]
  ///
  /// [data] - Data for authorization
  Future<AuthResponse> login(Map<String, Object?> data);
}

class DirectusAuthDelegate extends AuthDelegate {
  DirectusAuthDelegate([String? path]) : _path = path ?? 'auth/login';

  final String _path;

  @override
  Future<AuthResponse> login(Map<String, Object?> data) async {
    final dioResponse = await client.post(_path, data: data);
    return AuthResponse.fromResponse(dioResponse);
  }
}
