import 'package:dio/dio.dart';

class Tfa {
  Dio client;
  Tfa({required this.client});

  Future<void> enable(String password) async {
    await client.post('/users/tfa/enable', data: {'password': password});
  }

  Future<void> disable(String otp) async {
    await client.post('/users/tfa/disable', data: {'otp': otp});
  }
}
