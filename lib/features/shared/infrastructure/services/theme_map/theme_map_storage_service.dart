// ? ABSTRACCION
abstract class ThemeMapStorageService {
  Future<int> getValueThemeMap( String key );
  Future<void> setValueThemeMap( String key, int value );
}