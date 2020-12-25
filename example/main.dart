// @dart=2.9

import 'package:directus/directus.dart';
import 'package:directus/src/data_classes/directus_error.dart';
import 'package:directus/src/stores/directus_store.dart';

class Storage extends DirectusStorage {
  @override
  Future getItem(String key) async {}

  @override
  Future<void> setItem(String key, value) async {}
}

void main() async {
  final sdk = await Directus('http://localhost:8055').init();

  try {
    final response = await sdk.items('posts').readMany();

    print(response.data);
  } on DirectusError catch (error) {
    print(error.message);
  }
}
