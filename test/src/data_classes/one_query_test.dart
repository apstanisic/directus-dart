import 'package:directus/src/data_classes/data_classes.dart';
import 'package:directus/src/data_classes/one_query.dart';
import 'package:test/test.dart';

void main() {
  group('OneQuery', () {
    test('that converts to map properly', () {
      final query = OneQuery(
        fields: ['name', 'email'],
      );

      expect(query.toMap(), {
        'fields': 'name,email',
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
      final query = OneQuery(deep: {
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
  });
}
