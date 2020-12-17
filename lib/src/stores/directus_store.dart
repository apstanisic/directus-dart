abstract class DirectusStore {
  Future<String?> getString(String key);
  Future<void> setString(String key, String value);
}
