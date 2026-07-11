import 'package:shared_preferences/shared_preferences.dart';

import 'theme.dart';

class ThemeValueAppStorageServiceImpl extends ThemeValueAppStorageService {

  Future<SharedPreferences> getInstanceSharedPreferences() async{
    return await SharedPreferences.getInstance();
  }

  @override
  Future<int> getValueTheme(String key) async{
    final prefs = await getInstanceSharedPreferences();
    return prefs.getInt(key) ?? 0;
  }

  @override
  Future<void> setValueTheme(int value, String key) async{
    final prefs = await getInstanceSharedPreferences();
    await prefs.setInt(key, value);
  }
  
}
