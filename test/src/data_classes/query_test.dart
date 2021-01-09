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

// Regression test
  test('that filter is also converted to map.', () {
    final query = Query();
    final queryMap = query.toMap(
      filters: Filters({
        'one': Filter.eq(2),
        'two': Filter.gte(3),
      }),
    );

    expect(queryMap, {
      'filter': {
        'one': {'_eq': 2},
        'two': {'_gte': 3},
      }
    });
  });
}
