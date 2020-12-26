import 'package:directus/directus.dart';

void main() async {
  final sdk = await Directus('http://localhost:8055').init();

  try {
    final response = await sdk.items('posts').readMany();

    print(response.data);
  } on DirectusError catch (error) {
    print(error.message);
  }
}
