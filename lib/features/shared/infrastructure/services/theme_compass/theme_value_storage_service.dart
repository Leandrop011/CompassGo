
abstract class ThemeValueStorageService {
  Future<int> getValueThemeCompass( String key );
  Future<void> setValueThemeCompass( String key, int value );
}