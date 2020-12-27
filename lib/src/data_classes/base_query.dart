import 'data_classes.dart';

/// This query can be used for `readOne` or `readMany` methods.
class BaseQuery {
  BaseQuery({this.deep, this.fields});

  /// List of all fields that should be returned.
  ///
  /// If value is null, server will default to `['*']`. You can do joins by
  /// calling fields with `.*` after column name.
  /// For example `['*', 'user_id.*']` will get all data from current item, and join
  /// `user_id` field with proper table, and get all data.
  ///
  /// Example:
  /// ```dart
  /// fields = ['*'];
  /// fields = ['id', 'title'];
  /// fields = ['id', 'user.*'];
  /// ```
  /// [Additional info](https://github.com/directus/directus/blob/main/docs/reference/api/query/fields.md)
  List<String>? fields;

  /// [deep] is used to apply any of the other query params to nested data sets.
  ///
  ///```dart
  /// deep = {
  ///   'favorites': Query(limit: 5)
  /// };
  ///
  ///```
  /// [Additional info](https://github.com/directus/directus/discussions/3424)
  Map<String, Query>? deep;

  /// Convert [BaseQuery] to [Map] so it can be sent in HTTP request.
  Map<String, dynamic> toMap() {
    return {
      'fields': fields?.join(','),
      'deep': deep?.map((key, value) => MapEntry(key, value.toMap())),
    }..removeWhere(
        (key, value) => value == null,
      );
  }
}
