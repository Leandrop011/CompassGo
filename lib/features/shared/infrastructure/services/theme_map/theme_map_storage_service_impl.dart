
import 'package:compass_app/features/shared/infrastructure/services/theme_map/theme_map.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeMapStorageServiceImpl extends ThemeMapStorageService {
  // ? INSTANCIA
  Future<SharedPreferences> getSharedPreferences() async{
    return await SharedPreferences.getInstance();
  }
  
  // ? METODO GET
  @override
  Future<int> getValueThemeMap(String key) async{
    final prefs = await getSharedPreferences();

    return prefs.getInt(key) ?? 1;

  }

  // ? METODO SET
  @override
  Future<void> setValueThemeMap(String key, int value) async{
    final prefs = await getSharedPreferences();

    await prefs.setInt(key, value);
  }
  
}