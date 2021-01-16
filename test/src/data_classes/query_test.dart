import 'package:directus/src/data_classes/data_classes.dart';
import 'package:directus/src/data_classes/query.dart';
import 'package:test/test.dart';

void main() {
  test('Query can be empty', () {
    expect(Query().toMap(), {});
  });

  test('Query converts to map properly', () {
    final query = Query(
      fields: ['name', 'email'],
      limit: 5,
      offset: 4,
      meta: Meta(filterCount: true, totalCount: true),
      sort: ['id', '-created'],
    );

    expect(query.toMap(), {
      'fields': 'name,email',
      'limit': 5,
      'offset': 4,
      'meta': 'total_count,filter_count',
      'sort': 'id,-created',
    });
  });

// Regression test. It checks that [Filter.toMap] is called.
  test('filter is also converted to a map', () {
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
