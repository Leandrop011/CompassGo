// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:compass_app/features/shared/shared.dart';
import 'package:flutter_riverpod/legacy.dart';

const keyTutorialApp = 'key-tutorial-app';

// ! PROVIDER
final tutorialValueProvider = StateNotifierProvider.autoDispose<TutorialValueNotifier, TutorialValueState>((ref) {
  final TutorialValueStorageServiceImpl tutorialValueStorageServiceImpl = TutorialValueStorageServiceImpl();
  return TutorialValueNotifier( tutorialValueStorageService: tutorialValueStorageServiceImpl );
});
// ! NOTIFIER

class TutorialValueNotifier extends StateNotifier<TutorialValueState> {

  final TutorialValueStorageService tutorialValueStorageService;

  TutorialValueNotifier({
    required this.tutorialValueStorageService
  }): super(TutorialValueState()){
    getTutotialValue();
  }
  // ? METODO PARA OBTENER EL TUTORIAL VALUE GUARDADO LOCALMENTE
  void getTutotialValue () async{
    final tutorialValueStorage = await tutorialValueStorageService.getTutorialValue(keyTutorialApp);
    state = state.copyWith(
      value: tutorialValueStorage,
    );
  }
  // ? METODO PARA GUARDAR EL TUTORIAL VALUE LOCALMENTE
  void setTutorialValueStorage( bool value ) async{
    await tutorialValueStorageService.setTutorialValue(value, keyTutorialApp);
  }
  // ? METODO PARA CAMBIAR EL ESTADO DE LA PROPERTY TUTORIAL VALUE
  void changeTutorialValue(bool value){
    setTutorialValueStorage(value);
    state = state.copyWith(
      value: value,
    );
  }

}

// ! STATE
class TutorialValueState {
  final bool value;

  TutorialValueState({
    this.value = true
  });
  

  TutorialValueState copyWith({
    bool? value,
  }) => TutorialValueState(
      value: value ?? this.value,
  );
  
}
