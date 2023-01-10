import 'package:directus/directus.dart';

// class Article {}

// class ConverterNew extends ItemsConverter<Article> {
//   @override
//   Article fromJson(Map<String, Object?> data) {
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, Object?> toJson(Article data) {
//     throw UnimplementedError();
//   }
// }

void main() async {
  final sdk = await Directus('http://localhost:8055').init();
  final results = await sdk.items('posts').readMany();
  // ignore: avoid_print
  print(results);
}
