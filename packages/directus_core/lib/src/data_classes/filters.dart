import 'data_classes.dart';

/// Object used for filtering items from collection.
///
/// Provide [Map] in which key represent column name, and value is [Filter].
/// [Filter] provides named constructor for every comparison available.
/// If you use `OR` or `AND`, [Map]'s key will be ignored.
/// You can also use [F] instead of [Filter], it's an alias, so it's the same
///
/// ```dart
/// Filters({
///   'name': Filter.eq('John'),
///   'email': Filter.contains('@gmail.com');
///   'favorite_food': Filter.notNull(),
///   'and': and([
///     {'age': Filter.gte(20)},
///     {'age': Filter.lte(70)},
///   ]),
/// });
///
/// Filters({
///   'name': F.eq('John'),
/// });
///
/// ```
/// [Additional info](https://github.com/directus/directus/blob/main/docs/reference/api/query/filter.md)
class Filters {
  /// Filters
  Map<String, Object?> data;

  /// Set filters.
  Filters(this.data);

  /// Convert filters to map so it can be passed to [Dio].
  Map<String, Object?> toMap() {
    return data.map((field, value) {
      if (value is Filter) return value.toMapEntry(field);
      return MapEntry(field, value);
    });
  }
}
