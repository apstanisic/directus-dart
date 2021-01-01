import 'package:directus/src/data_classes/data_classes.dart';
import 'package:directus/src/data_classes/query.dart';
import 'package:test/test.dart';

void main() {
  test('Query converts to map properly', () {
    final query = Query(
      fields: ['name', 'email'],
      limit: 5,
      offset: 4,
      sort: ['id', '-created'],
    );

    expect(query.toMap(), {
      'fields': 'name,email',
      'limit': 5,
      'offset': 4,
      'sort': 'id,-created',
    });
  });
}
