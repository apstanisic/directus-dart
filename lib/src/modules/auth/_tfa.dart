// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

/// Two factor authentication.
class Tfa {
  @visibleForTesting
  Dio client;

  Tfa({required this.client});

  /// Enable 2FA.
  Future<void> enable(String password) async {
    await client.post('users/tfa/enable', data: {'password': password});
  }

  /// Disable 2FA.
  Future<void> disable(String otp) async {
    await client.post('users/tfa/disable', data: {'otp': otp});
  }
}
