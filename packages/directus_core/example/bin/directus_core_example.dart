import 'package:directus_core/directus_core.dart';
import 'package:directus_core_example/example_core.dart';

class MyArticle {
  MyArticle(this.id);
  int id;
}

class ArticleConverter extends ItemsConverter<MyArticle> {
  @override
  Map<String, Object?> toJson(MyArticle data) {
    return {"id": data.id};
  }

  @override
  MyArticle fromJson(Map<String, Object?> data) {
    return MyArticle(data['id'] as int);
  }
}

Future<void> main(List<String> arguments) async {
  try {
    final sdk = await getSdkSingleton();

    // await sdk.items('product').readMany(
    //       filters: Filters(
    //         {"[translations][_filter][languages_code][_eq]": 'en'},
    //       ),
    //     );
    final res = await sdk.items('product').readMany(
        query: Query(
            limit: 1, offset: 0, fields: ['sku', 'image', 'translations.*']),
        filters: Filters({
          'and': Filter.and([
            {'sku': Filter.eq('hello')},
            {'translations': Filter.relation('languages_code', Filter.eq('en'))}
          ])
        }));
    print(res.data);
  } catch (e) {
    print(e);
  }
}

// GET /items/product?filter%5B_and%5D%5B0%5D%5Bsku%5D%5B_eq%5D=hello&filter%5B_and%5D%5B1%5D%5Btranslations%5D%5Blanguages_code%5D%5B_eq%5D=en&fields=sku%2Cimage%2Ctranslations.%2A&limit=1&offset=0
// /items/product?filter[_and][0][sku][_eq]=hello&filter[_and][1][translations][languages_code][_eq]=en&fields=sku,image,translations.*&limit=1&offset=0