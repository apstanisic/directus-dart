abstract class DirectusStore {
  Future<String?> getItem(String key);
  Future<void> setItem(String key, String value);
}
