import 'one_query.dart';
import 'data_classes.dart';

/// All options that can be passed to and [ItemsHandler.readMany].
///
/// Every field is optional. It has all properties that can be used
/// to [ItemsHandler.readOne], with additional one for things
/// that are only needed when returning multiple items.
/// [Filters] are seperate property, and they are passed as seperate named param.
///
/// ```dart
/// Query(
///   limit: 5,
///   offset: 3,
///   fields: ['id', 'name'],
///   sort: ['name'],
/// );
/// ```
class Query extends OneQuery {
  /// List of fields used to sort the fetched items.
  ///
  /// It's sorted in orded in which columns are provided.
  /// You can prefix column name with `-` to reverse sort from ASC to DESC.
  /// ```dart
  /// sort = ['name', '-date_created'];
  /// ```
  /// [Additional info](https://github.com/directus/directus/blob/main/docs/reference/api/query/sort.md)
  List<String>? sort;

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
    this.limit,
    this.offset,
    this.sort,
    Map<String, Query>? deep,
    List<String>? fields,
  }) : super(deep: deep, fields: fields);

  /// Convert [Query] to [Map] so it can be passed to Dio for request.
  ///
  /// It accepts optional filter param that can be added to query to be sent
  /// with. [Filters] have seperate class and should be passed seperatly in methods.
  /// Fields where value is not set, will not be sent.
  @override
  Map<String, dynamic> toMap({Filters? filters}) {
    return {
      'filter': filters,
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
