import 'data_classes.dart';

class Query {
  /// List of all fields that should be returned.
  ///
  ///
  /// It defaults to all fields.
  ///
  /// Example:
  /// ```dart
  /// fields = ['*'];
  /// fields = ['id', 'title'];
  /// fields = ['id', 'user.*'];
  /// ```
  /// [Additional info](https://github.com/directus/directus/blob/main/docs/reference/api/query/fields.md)
  List<String>? fields;

  /// List of fields used to sort the fetched items.
  ///
  /// You can add `-` before field to reverse sort from ASC to DESC
  /// ```dart
  /// sort = ['name', '-date_created'];
  /// ```
  /// [Additional info](https://github.com/directus/directus/blob/main/docs/reference/api/query/sort.md)
  List<String>? sort;

  /// Object used for filtering items from collection.
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

  /// Used to apply any of the other query params to nested data sets
  ///
  /// [Additional info](https://github.com/directus/directus/discussions/3424)
  Map<String, Query>? deep;

  Query({
    this.deep,
    this.fields,
    this.filter,
    this.limit,
    this.offset,
    this.sort,
  });

  /// Convert [Query] to [Map] so it can be passed to Dio for request
  ///
  /// Fields where value is not set, will not be sent
  Map<String, dynamic> toMap() {
    return {
      'filter': filter?.map((field, value) => value.toMapEntry(field)),
      'fields': fields?.join(','),
      'limit': limit,
      'offset': offset,
      'sort': sort?.join(','),
      'deep': deep?.map((key, value) => MapEntry(key, value.toMap())),
    }..removeWhere((key, value) => value == null);
  }
}
