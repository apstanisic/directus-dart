// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/data_classes.dart';

class CurrentUser {
  Dio client;
  CurrentUser({required this.client});
// Get current user
  Future<DirectusResponse<Map<String, dynamic>>> read() async {
    final response = await client.get('/users/me');
    return DirectusResponse(response);
  }

// Update current user
  Future<DirectusResponse<Map<String, dynamic>>> update({required Map data}) async {
    final response = await client.patch('/users/me', data: data);
    return DirectusResponse(response);
  }
}
