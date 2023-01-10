import 'package:dio/dio.dart';
import 'package:directus_core/src/data_classes/data_classes.dart';
import 'package:directus_core/src/modules/users/directus_user.dart';
import 'package:directus_core/src/modules/users/user_converter.dart';

class CurrentUser {
  Dio client;
  CurrentUser({required this.client});
// Get current user
  Future<DirectusResponse<DirectusUser>> read() async {
    return DirectusResponse.fromRequest(() => client.get('users/me'),
        converter: UserConverter());
  }

// Update current user
  Future<DirectusResponse<DirectusUser>> update(
      {required DirectusUser data}) async {
    final mapData = data.toJson();
    return DirectusResponse.fromRequest(
      () => client.patch('users/me', data: mapData),
      converter: UserConverter(),
    );
  }
}
