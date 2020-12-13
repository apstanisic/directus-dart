import 'package:directus/src/query/filter.dart';

class Query {
  /// Fields that should be returned
  List<String>? fields;
  String? sort;
  Filters? filter;

  /// Limit amount of items to be returned
  int? limit;

  /// Offset items to be returned
  int? offset;

  /// Page for pagination
  int? page;
  String? search;
  Map<String, Query>? deep;

  /// Either ['json' | 'csv']
  String? export;

  Query({
    this.deep,
    this.export,
    this.fields,
    this.filter,
    this.limit,
    this.offset,
    this.page,
    this.search,
    this.sort,
  });

  Map<String, dynamic> toMap() {
    // ignore: omit_local_variable_types
    final Map<String, dynamic> query = {};
    if (filter != null) query['filter'] = filter?.toMap();
    if (deep != null) query['deep'] = deep;
    if (export != null) query['export'] = export;
    if (fields != null) query['fields'] = fields;
    if (limit != null) query['limit'] = limit;
    if (offset != null) query['offset'] = offset;
    if (page != null) query['page'] = page;
    if (search != null) query['search'] = search;
    if (sort != null) query['sort'] = sort;

    return query;
  }
}
