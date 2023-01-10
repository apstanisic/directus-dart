import 'package:dio/dio.dart';
import 'package:directus_core/src/data_classes/directus_error.dart';

class ForgottenPassword {
  Dio client;
  ForgottenPassword({required this.client});

  /// Request password to be sent to your email
  Future<void> request(String email) async {
    try {
      await client.post('auth/password/request', data: {'email': email});
    } catch (e) {
      DirectusError.fromDio(e);
    }
  }

  /// Reset password
  ///
  /// Provide [token] and new [password] that you want to set.
  Future<void> reset({required String token, required String password}) async {
    try {
      await client.post('auth/password/reset',
          data: {'token': token, 'password': password});
    } catch (e) {
      DirectusError.fromDio(e);
    }
  }
}
