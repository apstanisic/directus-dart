/// Used for getting objects from and to [Map].
///
/// This is used for most handlers that
/// extend [ItemsHandler] for getting statically typed object. There are only 2 methods
/// that need to be overridden, [fromJson] and [toJson].
/// If user is using `json_serializable` it's pretty straight forward to write converter.
/// Default converter form [ItemsHandler] is [MapItemsConverter] that will simply clone
/// [Map] to another [Map]. You can check how [SettingsConverter], [ActivityConverter],
/// or similar classes work.
/// [Map] must have [String] as `key`, because that's only valid value for JSON.
abstract class ItemsConverter<T> {
  /// Converts item from [Map] to [T]
  T fromJson(Map<String, Object?> data);

  /// Converts item from [T] to [Map]
  Map<String, Object?> toJson(T data);
}
