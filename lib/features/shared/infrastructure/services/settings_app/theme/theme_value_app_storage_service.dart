
abstract class ThemeValueAppStorageService {
  Future<int> getValueTheme(String key);
  Future<void> setValueTheme(int value, String key);
}