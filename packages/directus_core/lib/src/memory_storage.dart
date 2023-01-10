import '../directus_core.dart';

/// MemoryStorage is mainly used for testing
class MemoryStorage extends DirectusStorage {
  final Map<String, Object> _store = {};

  /// Get item from storage
  @override
  Future<Object?> getItem(String key) async {
    return _store[key];
  }

  /// Set item to storage
  ///
  @override
  Future<void> setItem(String key, Object value) async {
    _store[key] = value;
  }

  /// Remove item from storage
  @override
  Future<void> removeItem(String key) async {
    _store.remove(key);
  }
}
