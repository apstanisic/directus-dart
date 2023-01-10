import 'package:directus_core/src/data_classes/data_classes.dart';
import 'package:test/test.dart';

void main() {
  test('Filter constructors set correct values', () async {
    final filters = Filters({
      'zero': Filter('value'),
      'one': Filter.eq('value'),
      'two': Filter.notEq('value'),
      'three': Filter.gt('value'),
      'four': Filter.gte('value'),
      'five': Filter.lt('value'),
      'six': Filter.lte('value'),
      'seven': Filter.contains('value'),
      'eight': Filter.notContains('value'),
      'nine': Filter.empty(),
      'ten': Filter.notEmpty(),
      'eleven': Filter.isNull(),
      'twelve': Filter.notNull(),
      'thirteen': Filter.between(1, 5),
      'fourteen': Filter.notBetween(2, 6),
      'fiveteen': Filter.isIn(['value']),
      'sixteen': Filter.notIn(['value']),
      'author': Filter.relation(
        'name',
        Filter.eq('Rijk van Zanten'),
      ),
    }).toMap();

    expect(filters['zero'], {'_eq': 'value'});
    expect(filters['one'], {'_eq': 'value'});
    expect(filters['two'], {'_neq': 'value'});
    expect(filters['three'], {'_gt': 'value'});
    expect(filters['four'], {'_gte': 'value'});
    expect(filters['five'], {'_lt': 'value'});
    expect(filters['six'], {'_lte': 'value'});
    expect(filters['seven'], {'_contains': 'value'});
    expect(filters['eight'], {'_ncontains': 'value'});
    expect(filters['nine'], {'_empty': true});
    expect(filters['ten'], {'_nempty': true});
    expect(filters['eleven'], {'_null': true});
    expect(filters['twelve'], {'_nnull': true});
    expect(filters['thirteen'], {
      '_between': [1, 5]
    });
    expect(filters['fourteen'], {
      '_nbetween': [2, 6]
    });
    expect(filters['fiveteen'], {
      '_in': ['value']
    });
    expect(filters['sixteen'], {
      '_nin': ['value']
    });
    expect(filters['author'], {
      'name': {
        '_eq': 'Rijk van Zanten',
      },
    });
  });

  test('Filter converts to MapEntry', () {
    final filter = Filter.eq('value').toMapEntry('field');

    expect(filter.key, 'field');
    expect(filter.value, {'_eq': 'value'});
  });

  test('Filter converts `and` comparisson', () {
    final filter = Filter.and([
      {'one': Filter.eq(2)},
      {'three': Filter.eq(4)},
      {'five': Filter.eq(6)},
    ]);
    final filterList =
        filter.convertFilterList(filter.value as List<Map<String, Filter>>);

    expect(filterList.length, 3);

    expect(filterList[0], {
      'one': {'_eq': 2}
    });

    expect(filterList[1], {
      'three': {'_eq': 4}
    });

    expect(filterList[2], {
      'five': {'_eq': 6}
    });
  });

  test('Filter converts  `or` comparisson', () {
    final filter = Filter.or([
      {'one': Filter.eq(2)},
      {'three': Filter.eq(4)},
      {'five': Filter.eq(6)},
    ]);
    final filterList =
        filter.convertFilterList(filter.value as List<Map<String, Filter>>);

    expect(filterList.length, 3);

    expect(filterList[0], {
      'one': {'_eq': 2}
    });

    expect(filterList[1], {
      'three': {'_eq': 4}
    });

    expect(filterList[2], {
      'five': {'_eq': 6}
    });
  });

  test('Filter `and` and `or` ignore provided key', () {
    final filterAnd = Filter.and([
      {'one': Filter.eq(2)},
    ]);
    final filterOr = Filter.or([
      {'one': Filter.eq(2)},
    ]);

    final andEntry = filterAnd.toMapEntry('any-random-value');
    expect(andEntry.key, '_and');
    expect(andEntry.value, isList);

    final orEntry = filterOr.toMapEntry('any-random-value');
    expect(orEntry.key, '_or');
    expect(orEntry.value, isList);
  });
}
