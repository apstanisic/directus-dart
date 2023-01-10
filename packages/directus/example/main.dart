import 'package:directus/directus.dart';

void main() async {
  final sdk = await Directus('http://localhost:8055').init();
  final results = await sdk.items('posts').readMany();
  // ignore: avoid_print
  print(results);
}
