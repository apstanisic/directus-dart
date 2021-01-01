abstract class ItemsConverter<T> {
  /// Converts item from [Map] to [T]
  T fromJson(Map<String, dynamic> data);

  /// Converts item from [T] to [Map]
  Map<String, dynamic> toJson(T data);
}
