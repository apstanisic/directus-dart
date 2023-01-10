import 'package:directus_core/src/data_classes/data_classes.dart';
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

    test('Deep transforms to map recursively', () {
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

    test('User can set custom params', () {
      final query = OneQuery(
        deep: {},
        customParams: {'cp': 'test'},
        fields: ['id'],
      );
      expect(query.toMap(), {'deep': {}, 'fields': 'id', 'cp': 'test'});
    });

    test('customParams wont overwrite other options', () {
      final query = OneQuery(
        fields: ['id'],
        deep: {},
        customParams: {'deep': 'test', 'fields': 'test', 'random': 'value'},
      );
      expect(query.toMap(), {'deep': {}, 'fields': 'id', 'random': 'value'});
    });
  });
}
