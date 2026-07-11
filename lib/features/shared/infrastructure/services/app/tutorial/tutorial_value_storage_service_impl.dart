import 'package:shared_preferences/shared_preferences.dart';
import 'tutorial.dart';

class TutorialValueStorageServiceImpl extends TutorialValueStorageService {

  Future<SharedPreferences> getInstanceSharedPreferences() async{
    return await SharedPreferences.getInstance();
  }

  @override
  Future<bool> getTutorialValue(String key) async{
    final prefs = await getInstanceSharedPreferences();
    return prefs.getBool(key) ?? false;
  }

  @override
  Future<void> setTutorialValue(bool value, String key) async{
    final prefs = await getInstanceSharedPreferences();
    await prefs.setBool(key, value);
  }
  
}