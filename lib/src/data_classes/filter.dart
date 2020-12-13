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
  late String field;
  String? comparisson;
  late dynamic value;

  Filter(this.field, this.value);

  Filter.or(List<Filter> filters) {
    field = '_or';
    value = filters;
  }

  Filter.eq(this.field, this.value) : comparisson = '_eq';
  Filter.neq(this.field, this.value) : comparisson = '_eq';

  Filter.contains(this.field, this.value) : comparisson = '_contains';
  Filter.ncontains(this.field, this.value) : comparisson = '_ncontains';

  Filter.isIn(this.field, this.value) : comparisson = '_in';
  Filter.notIn(this.field, this.value) : comparisson = '_nin';
}
