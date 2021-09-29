import 'package:meta/meta.dart';

import 'data_classes.dart';

/// All options that can be passed to some of [ItemsHandler] methods.
///
/// This query can be used for both [ItemsHandler.readOne] and [ItemsHandler.readMany] methods,
/// but [Query] is offering more options for [ItemsHandler.readMany].
/// It can also be passed to update and create methods, for specifying what data to be returned.
class OneQuery {
  /// Constructor
  OneQuery({this.deep, this.fields, this.customParams});

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

  /// Custom url params.
  ///
  /// Allows user to pass additional url params to Directus API.
  Map<String, Object?>? customParams;

  /// Token for accessing protected data.
  ///
  /// Admin can set token for user that allows to access data without login.
  /// This token is visible in url, and should only be used in development or over DoH.
  /// TODO(apstanisic): See should there be option for this or should we just use custom params.
  @visibleForTesting
  @experimental
  String? unsafeAccessToken;

  /// Convert [OneQuery] to [Map] so it can be sent in HTTP request.
  Map<String, Object?> toMap() {
    return <String, Object?>{
      if (customParams != null) ...customParams!,
      if (unsafeAccessToken != null) 'access_token': unsafeAccessToken,
      'fields': fields?.join(','),
      'deep': deep?.map((key, value) => MapEntry(key, value.toMap())),
    }..removeWhere(
        (key, value) => value == null,
      );
  }
}
