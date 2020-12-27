import 'base_query.dart';
import 'data_classes.dart';

/// All options that can be passed to [DirectusSdk.readOne], and [DirectusSdk.readMany].
///
/// Every field is optional.
///
/// ```dart
/// final query = Query(
///   limit: 5,
///   offset: 3,
///   fields: ['id', 'name'],
///   sort: ['name'],
///   filter: {
///     'name': Filter.eq('Aleksandar'),
///   },
/// );
///
/// ```
class Query extends BaseQuery {
  /// List of fields used to sort the fetched items.
  ///
  /// It's sorted in orded in which columns are provided.
  /// You can prefix column name with `-` to reverse sort from ASC to DESC.
  /// ```dart
  /// sort = ['name', '-date_created'];
  /// ```
  /// [Additional info](https://github.com/directus/directus/blob/main/docs/reference/api/query/sort.md)
  List<String>? sort;

  /// Object used for filtering items from collection.
  ///
  /// Provide [Map] in which key represent column name, and value is [Filter].
  /// [Filter] provides named constructor for every comparisson available.
  /// If you use `OR` or `AND`, [Map]'s key will be ignored.
  /// ```dart
  /// filter = {
  ///   'name': Filter.eq('Aleksandar'),
  ///   'email': Filter.contains('@gmail.com');
  ///   'favorite_food': Filter.notNull(),
  ///   'and': Filter.and([
  ///     {'age': Filter.gte(20)},
  ///     {'age': Filter.lte(70)},
  ///   ]),
  /// };
  /// ```
  ///
  /// [Additional info](https://github.com/directus/directus/blob/main/docs/reference/api/query/filter.md)
  Map<String, Filter>? filter;

  /// Limit amount of items to be returned.
  ///
  /// Can be used with [offset] for simple pagination.
  ///
  /// [Additional info](https://github.com/directus/directus/blob/main/docs/reference/api/query/limit.md)
  int? limit;

  /// Offset items to be returned.
  ///
  /// Can be used with [limit] for simple pagination.
  ///
  /// [Additional info](https://github.com/directus/directus/blob/main/docs/reference/api/query/offset.md)
  int? offset;

  /// Constructor for query. All fields are optional.
  Query({
    this.filter,
    this.limit,
    this.offset,
    this.sort,
    Map<String, Query>? deep,
    List<String>? fields,
  }) : super(deep: deep, fields: fields);

  /// Convert [Query] to [Map] so it can be passed to Dio for request.
  ///
  /// Fields where value is not set, will not be sent.
  @override
  Map<String, dynamic> toMap() {
    return {
      'filter': filter?.map((field, value) => value.toMapEntry(field)),
      'fields': fields?.join(','),
      'limit': limit,
      'offset': offset,
      'sort': sort?.join(','),
      'deep': deep?.map((key, value) => MapEntry(key, value.toMap())),
    }..removeWhere(
        (key, value) => value == null,
      );
  }
}
