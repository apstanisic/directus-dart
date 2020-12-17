/// Filters for Directus query
/// ```dart
/// final filters = Filters([
///   Filter.isIn('post_name', ['pn1', 'pn2']),
///   Filter('test', 'some-value'),
///   Filter.or([
///     Filter('one', 'two'),
///     Filter('three', 'four')
///   ])
/// ]);
///
/// ```
class Filters {
  List<Filter> filters;

  Filters(this.filters);

  Map toMap() {
    final map = {};
    filters.forEach((filter) {
      filterToItem(filter: filter, map: map);
    });
    return map;
  }

  /// Convert single filter to proper type and assigns it to provided map
  void filterToItem({required Filter filter, required Map map}) {
    if (map[filter.field] != null) throw Exception('Field ${filter.field} already exist');
    var value;
    if (filter.value is List) {
      value = (filter.value as List<Filter>).map((element) {
        var map = {};
        filterToItem(filter: element, map: map);
        return map;
      });
    } else {
      value = filter.value;
    }
    if (filter.comparisson == null) {
      map[filter.field] = value;
    } else {
      map[filter.field] = {filter.comparisson: value};
    }
  }
}

class Filter {
  /// Field name
  late String field;

  /// Comparisson that will be done (equal, not equal, less then...).
  String? comparisson;

  /// Value to compare it to
  dynamic value;

  /// Check if the values are equal
  Filter(this.field, this.value);

  // Check if at least one filter is true.
  Filter.or(List<Filter> filters) {
    field = '_or';
    value = filters;
  }

  // Check if at least one filter is true.
  Filter.and(List<Filter> filters) {
    field = '_and';
    value = filters;
  }

  /// Check if the values are equal.
  Filter.eq(this.field, this.value) : comparisson = '_eq';

  /// Check if the values are not equal.
  Filter.notEq(this.field, this.value) : comparisson = '_neq';

  /// Check to see if field contains value.
  Filter.contains(this.field, this.value) : comparisson = '_contains';

  /// Check to see if field does not contain value.
  Filter.notContains(this.field, this.value) : comparisson = '_ncontains';

  /// Check to see if value in is provided list.
  Filter.isIn(this.field, List this.value) : comparisson = '_in';

  /// Check to see if field in not is provided list.
  Filter.notIn(this.field, this.value) : comparisson = '_nin';

  /// Check to see if value is greater then.
  Filter.gt(this.field, this.value) : comparisson = '_gt';

  /// Check to see if value is greater then or equal.
  Filter.gte(this.field, this.value) : comparisson = '_gte';

  /// Check to see if value is less then.
  Filter.lt(this.field, this.value) : comparisson = '_lt';

  /// Check to see if value is less then or equal.
  Filter.lte(this.field, this.value) : comparisson = '_lte';

  /// Check to see if value is empty.
  Filter.empty(this.field) : comparisson = '_empty';

  /// Check to see if value is not empty.
  Filter.notEmpty(this.field) : comparisson = '_empty';

  /// Check to see if value is null.
  Filter.isNull(this.field) : comparisson = '_null';

  /// Check to see if value is not null.
  Filter.notNull(this.field) : comparisson = '_nnull';
}
