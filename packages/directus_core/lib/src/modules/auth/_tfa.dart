import 'package:dio/dio.dart';
import 'package:directus_core/src/data_classes/directus_error.dart';
import 'package:meta/meta.dart';

/// Two factor authentication.
class Tfa {
  @visibleForTesting
  Dio client;

  Tfa({required this.client});

  /// Enable 2FA.
  Future<void> enable(String password) async {
    try {
      await client.post('users/tfa/enable', data: {'password': password});
    } catch (e) {
      DirectusError.fromDio(e);
    }
  }

  /// Disable 2FA.
  Future<void> disable(String otp) async {
    try {
      await client.post('users/tfa/disable', data: {'otp': otp});
    } catch (e) {
      DirectusError.fromDio(e);
    }
  }
}
