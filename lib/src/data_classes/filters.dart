import 'data_classes.dart';

/// Object used for filtering items from collection.
///
/// Provide [Map] in which key represent column name, and value is [Filter].
/// [Filter] provides named constructor for every comparisson available.
/// If you use `OR` or `AND`, [Map]'s key will be ignored.
/// You can also use [F] instead of [Filter], it's an alias, so it's the same
///
/// ```dart
/// filter = Filters({
///   'name': Filter.eq('Aleksandar'),
///   'email': Filter.contains('@gmail.com');
///   'favorite_food': Filter.notNull(),
///   'and': and([
///     {'age': Filter.gte(20)},
///     {'age': Filter.lte(70)},
///   ]),
/// });
///
/// filter = Filters({
///   'name': F.eq('Aleksandar'),
/// });
///
/// ```
/// [Additional info](https://github.com/directus/directus/blob/main/docs/reference/api/query/filter.md)
Map<String, Filter>? filter;

class Filters {
  Map<String, Filter> data;

  Filters(this.data);

  Map<String, dynamic> toMap() {
    return data.map((field, value) => value.toMapEntry(field));
  }
}
