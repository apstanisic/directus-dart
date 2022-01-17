import 'filters.dart';
import 'one_query.dart';

/// All options that can be passed to and [ItemsHandler.readMany].
///
/// Every field is optional. It has all properties that can be used
/// to [ItemsHandler.readOne], with additional one for things
/// that are only needed when returning multiple items.
/// [Filters] are separate property, and they are passed as separate named param.
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
  /// It's sorted in order in which columns are provided.
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

  /// Metadata returns additional info about the query.
  ///
  /// [Additional info](https://github.com/directus/directus/blob/main/docs/reference/api/query/meta.md)
  Meta? meta;

  /// Custom url params
  // Map<String, Object?>? customParams;

  /// Constructor for query. All fields are optional.
  Query({
    this.limit,
    this.offset,
    this.sort,
    this.meta,
    Map<String, Query>? deep,
    List<String>? fields,
    Map<String, Object?>? customParams,
  }) : super(deep: deep, fields: fields, customParams: customParams);

  /// Convert [Query] to [Map] so it can be passed to Dio for request.
  ///
  /// It accepts optional filter param that can be added to query to be sent
  /// with. [Filters] have separate class and should be passed separately in methods.
  /// Fields where value is not set, will not be sent.
  @override
  Map<String, Object?> toMap({Filters? filters}) {
    return <String, Object?>{
      if (customParams != null) ...customParams!,
      'filter': filters?.toMap(),
      'fields': fields?.join(','),
      'limit': limit,
      'offset': offset,
      'meta': meta?.toString(),
      'sort': sort?.join(','),
      'deep': deep?.map((key, value) => MapEntry(key, value.toMap())),
    }..removeWhere(
        (key, value) => value == null,
      );
  }
}

/// What metadata response should return.
class Meta {
  bool? totalCount;
  bool? filterCount;

  Meta({this.filterCount, this.totalCount});

  /// Override [toString] is it returns [String] that can be used in request.
  ///
  /// In request it should look like this: `meta=total_count,filter_count`
  @override
  String toString() {
    return [
      if (totalCount == true) 'total_count',
      if (filterCount == true) 'filter_count'
    ].join(',');
  }
}
