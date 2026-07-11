
abstract class TutorialValueStorageService {
  Future<bool> getTutorialValue(String key);
  Future<void> setTutorialValue(bool value ,String key);
}