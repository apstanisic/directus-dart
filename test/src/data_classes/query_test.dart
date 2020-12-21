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

  test('Query transforms filter properly', () {
    final query = Query(filter: {
      'one': Filter.eq(2),
      'three': Filter.eq(4),
      'five': Filter.and([
        {'five.one': Filter.eq(2)},
        {'five.two': Filter.eq(4)},
      ])
    });

    expect(query.toMap(), {
      'filter': {
        'one': {'_eq': 2},
        'three': {'_eq': 4},
        '_and': [
          {
            'five.one': {'_eq': 2}
          },
          {
            'five.two': {'_eq': 4}
          },
        ]
      }
    });
  });

  test('Deep works', () {
    final query = Query(deep: {
      'one': Query(),
      'two': Query(),
    });

    expect(query.toMap(), {
      'deep': {'one': {}, 'two': {}}
    });
  });

  test('Deep transforms to map recursevly', () {
    final query = Query(deep: {
      'one': Query(limit: 5, deep: {'two': Query(offset: 5)})
    });

    expect(query.toMap(), {
      'deep': {
        'one': {
          'limit': 5,
          'deep': {
            'two': {'offset': 5},
          },
        },
      }
    });
  });
}
