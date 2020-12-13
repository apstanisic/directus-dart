import 'package:directus/directus.dart';
import 'package:directus/src/query/filter.dart';

void main() async {
  final sdk = DirectusSDK('http://example.com');

  await sdk.auth.login(email: 'admin@example.com', password: 'password');

  final items = await sdk.items('posts').readMany(
        query: Query(
          filter: Filters([
            Filter.eq('id', 5),
            Filter.neq('id', 6),
          ]),
        ),
      );
}
