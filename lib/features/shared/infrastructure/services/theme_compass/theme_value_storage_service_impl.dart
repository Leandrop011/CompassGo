import 'package:compass_app/features/shared/infrastructure/services/theme_compass/theme_value_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeValueStorageServiceImpl extends ThemeValueStorageService{

  // * INSTANCIA SHARED PREFERENCES
  Future<SharedPreferences> getSharedPreferences() async{
    return await SharedPreferences.getInstance();
  }

  // * METHOD GET VALUE
  @override
  Future<int> getValueThemeCompass(String key) async {
    final prefs = await getSharedPreferences();

    return prefs.getInt(key) ?? 0;
  }

  // * METHOD SET VALUE WITH A KEY
  @override
  Future<void> setValueThemeCompass(String key, int value) async{
    final prefs = await getSharedPreferences();
    
    await prefs.setInt(key, value);
  }
  
}