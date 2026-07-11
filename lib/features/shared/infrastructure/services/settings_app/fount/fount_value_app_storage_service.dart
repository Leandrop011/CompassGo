
abstract class FountValueStorageService {
  Future<void> setValueFount(bool value, String key);
  Future<bool> getValueFount(String key);
}