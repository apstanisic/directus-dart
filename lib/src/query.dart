class Query {
  List<String>? fields;
  String? sort;
  dynamic? filter;
  int? limit;
  int? offset;
  int? page;
  String? search;
  Map? deep;

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
    return {
      'deep': deep,
      'export': export,
      'fields': fields,
      'filter': filter,
      'limit': limit,
      'offset': offset,
      'page': page,
      'search': search,
      'sort': sort,
    };
  }
}
