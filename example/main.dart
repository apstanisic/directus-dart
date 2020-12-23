import 'package:directus/directus.dart';

void main() async {
  final sdk = await Directus('http://localhost:8055').init();

  await sdk.auth.login(email: 'admin@example.com', password: 'password');

  final items = await sdk.items('posts').readMany(
        query: Query(
          filter: {
            'id': Filter.gte(4),
          },
        ),
      );
}
