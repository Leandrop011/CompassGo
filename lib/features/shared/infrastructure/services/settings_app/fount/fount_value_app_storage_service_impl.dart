import 'package:shared_preferences/shared_preferences.dart';

import 'fount.dart';

class FountValueStorageServiceImpl extends FountValueStorageService {

  Future<SharedPreferences> getInstancePreferences() async{
    return await SharedPreferences.getInstance();
  }

  @override
  Future<bool> getValueFount(String key) async{
    final prefs = await getInstancePreferences();
  
    return prefs.getBool(key) ?? true;
  }

  @override
  Future<void> setValueFount(bool value, String key) async{
    final prefs = await getInstancePreferences();
    await prefs.setBool(key, value);
  }
  
}