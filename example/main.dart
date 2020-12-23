import 'package:directus/directus.dart';

void main() async {
  final sdk = DirectusSDK('http://localhost:8055', storagePath: 'storage');
  await sdk.init();

  await sdk.auth.login(email: 'admin@example.com', password: 'password');

  final items = await sdk.items('posts').readMany(
        query: Query(
          filter: {
            'id': Filter.eq(4),
          },
        ),
      );
}
