import 'dart:io';

import 'package:directus_core/directus_core.dart';

/// Replace this with env_placeholder.dart
import 'package:directus_core_example/env.dart';

Future<DirectusCore> getSdkSingleton() async {
  await DirectusCoreSingleton.init(DirectusConst.url, storage: MemoryStorage());

  final sdk = DirectusCoreSingleton.instance;
  await sdk.auth
      .login(email: DirectusConst.username, password: DirectusConst.password);
  // await sdk.auth.login(email: 'test@example.com', password: 'password');
  return sdk;
}

Future<DirectusListResponse<DirectusUser>> getUsers() async {
  final sdk = await getSdkSingleton();
  // sdk.users.converter = AAA();
  return sdk.users.readMany(query: Query(limit: 1));
}

Future<DirectusResponse<DirectusUser>> createUser() async {
  final sdk = await getSdkSingleton();
  final user = DirectusUser(
    email: "john5@domain.tld",
    password: "password",
  );
  final res = await sdk.users.createOne(user);
  // sdk.users.converter = MyConverter();
  // print(res.data.rawValues['test_value']);
  return res;
}

/// THIS IS NOT WORKING
Future<DirectusResponse<DirectusField>> readFields() async {
  final sdk = await getSdkSingleton();

  final res = await sdk.fields.readOne("1");
  return res;
}

Future<DirectusResponse<DirectusFile>> uploadFile() async {
  final sdk = await getSdkSingleton();

  print(Directory.current.path);
  final res = await sdk.files
      .uploadFile('${Directory.current.path}/lib/some_data.json');
  return res;
}

class AAA implements ItemsConverter<Map<String, Object?>> {
  @override
  fromJson(Map<String, Object?> data) {
    return data;
  }

  @override
  toJson(Map<String, Object?> data) {
    return data;
  }
}
