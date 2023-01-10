import 'package:directus_core/src/data_classes/data_classes.dart';
import 'package:test/test.dart';

void main() {
  test('that Filters transforms filter properly', () {
    final filters = Filters({
      'one': Filter.eq(2),
      'three': Filter.eq(4),
      'five': Filter.and([
        {'five.one': Filter.eq(2)},
        {'five.two': Filter.eq(4)},
      ]),
      'custom': {
        'hello': 'world',
      }
    });

    expect(filters.toMap(), {
      'one': {'_eq': 2},
      'three': {'_eq': 4},
      '_and': [
        {
          'five.one': {'_eq': 2}
        },
        {
          'five.two': {'_eq': 4}
        },
      ],
      'custom': {
        'hello': 'world',
      }
    });
  });
}
