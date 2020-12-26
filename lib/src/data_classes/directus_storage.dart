abstract class DirectusStorage {
  Future<void> setItem(String key, dynamic value);
  Future<dynamic?> getItem(String key);
}
