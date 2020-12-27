// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';

class ForgottenPassword {
  Dio client;
  ForgottenPassword({required this.client});

  /// Request password to be sent to your email
  Future<void> request(String email) async {
    await client.post('/auth/password/request', data: {'email': email});
  }

  /// Reset password
  ///
  /// Provide [token] and new [password] that you want to set.
  Future<void> reset({required String token, required String password}) async {
    await client.post('/auth/password/reset', data: {'token': token, 'password': password});
  }
}
