import 'package:directus/directus.dart';

void main() async {
  final sdk = await Directus('http://localhost:8055', storagePath: 'storage').init();

  await sdk.auth.login(email: 'admin@example.com', password: 'password');

  final items = await sdk.items('posts').readMany(
        query: Query(
          filter: {
            'id': Filter.eq(4),
          },
        ),
      );
}
