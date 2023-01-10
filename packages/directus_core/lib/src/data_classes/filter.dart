import 'package:meta/meta.dart';

/// Used for filtering data
///
/// It should be used inside a map as a value for comparison
/// Example:
/// ```dart
/// final filter = {
///   'name': Filter.eq('John'),
///   'id': Filter.gte(5),
///   'amount': Filter.between(5, 10),
///   'or': Filter.or([
///     {'name': Filter.notEq('Evan')},
///     {'name': Filter.notEq('Mark')},
///   ]),
///   'author': Filter.relation(
///     'name',
///     Filter.eq('Rijk van Zanten'),
///    ),
/// };
/// ```
class Filter {
  /// Comparison that will be done (equal, not equal, less then...).
  final String comparison;

  /// Value to compare it to
  final Object? value;

  /// Check if the values are equal
  Filter(this.value) : comparison = '_eq';

  // Check if at least one filter is true.
  Filter.or(List<Map<String, Filter>> filters)
      : comparison = '_or',
        value = filters;

  // Check if at least one filter is true.
  Filter.and(List<Map<String, Filter>> filters)
      : comparison = '_and',
        value = filters;

  /// Check if the values are equal.
  Filter.eq(this.value) : comparison = '_eq';

  /// Check if the values are not equal.
  Filter.notEq(this.value) : comparison = '_neq';

  /// Check to see if field contains value.
  Filter.contains(this.value) : comparison = '_contains';

  /// Check to see if field does not contain value.
  Filter.notContains(this.value) : comparison = '_ncontains';

  /// Check to see if value in is provided list.
  Filter.isIn(List this.value) : comparison = '_in';

  /// Check to see if field in not is provided list.
  Filter.notIn(List this.value) : comparison = '_nin';

  /// Check to see if value is greater then.
  Filter.gt(this.value) : comparison = '_gt';

  /// Check to see if value is greater then or equal.
  Filter.gte(this.value) : comparison = '_gte';

  /// Check to see if value is less then.
  Filter.lt(this.value) : comparison = '_lt';

  /// Check to see if value is less then or equal.
  Filter.lte(this.value) : comparison = '_lte';

  /// Check to see if value is empty.
  Filter.empty()
      : comparison = '_empty',
        value = true;

  /// Check to see if value is not empty.
  Filter.notEmpty()
      : comparison = '_nempty',
        value = true;

  /// Check to see if value is null.
  Filter.isNull()
      : comparison = '_null',
        value = true;

  /// Check to see if value is not null.
  Filter.notNull()
      : comparison = '_nnull',
        value = true;

  /// Check to see if value is between.
  Filter.between(Object? from, Object? to)
      : comparison = '_between',
        value = [from, to];

  /// Check to see if value is not between.
  Filter.notBetween(Object? from, Object? to)
      : comparison = '_nbetween',
        value = [from, to];

  /// Relation
  const Filter.relation(String value, Filter filter)
      : value = filter,
        comparison = value;

  /// Convert [Filter][List] to [Map][List].
  ///
  /// This method is used for converting `and` and `or` filtering.
  @visibleForTesting
  List<Map<String, Object?>> convertFilterList(
      List<Map<String, Filter>> filters) {
    // For every item in List convert value from Filter to Map.
    return filters
        .map(
          (filterMap) =>
              filterMap.map((field, value) => value.toMapEntry(field)),
        )
        .toList();
  }

  /// Convert filter to [MapEntry], with provided [field] name.
  ///
  /// That way it can easily be converted to [Map] for passing to [Dio]
  MapEntry<String, Object?> toMapEntry(String field) {
    // If value is a list of non filters
    if (comparison == '_or' || comparison == '_and') {
      return MapEntry(
        comparison,
        convertFilterList(value as List<Map<String, Filter>>),
      );
    }

    // Relation
    final v = value;
    if (v != null && v is Filter) {
      final childMap = v.toMapEntry(comparison);
      return MapEntry(field, {childMap.key: childMap.value});
    }

    return MapEntry(field, {comparison: value});
  }
}

typedef F = Filter;
