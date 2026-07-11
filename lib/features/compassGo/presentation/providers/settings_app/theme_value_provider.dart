// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:compass_app/features/shared/shared.dart';
import 'package:flutter_riverpod/legacy.dart';

const keyThemeValue = 'theme-value-app';

// ! PROVIDER
final themeValueProvider = StateNotifierProvider.autoDispose<ThemeValueNotifier, ThemeValueState>((ref) {
  final ThemeValueAppStorageServiceImpl themeValueAppStorageServiceImpl = ThemeValueAppStorageServiceImpl();
  return ThemeValueNotifier( themeValueAppStorageService: themeValueAppStorageServiceImpl );
});

// ! NOTIFER
class ThemeValueNotifier extends StateNotifier<ThemeValueState> {

  final ThemeValueAppStorageService themeValueAppStorageService;

  ThemeValueNotifier({ 
    required this.themeValueAppStorageService
  }): super(ThemeValueState()){
    getValueTheme();
  }

  // ? METODO PARA OBTENER EL THEME VALUE GUARDADO LOCALMENTE
  void getValueTheme() async{
    final themeValueStorage = await themeValueAppStorageService.getValueTheme(keyThemeValue);

    state = state.copyWith(
      valueTheme: themeValueStorage,
    );
  }
  
  // ? METODO PARA GUARDAR LOCALMENTE EL THEME VALUE
  void setValueThemeStorage( int value ) async{
    await themeValueAppStorageService.setValueTheme(value, keyThemeValue);
  }

  // ? METODO PARA CAMBIAR DE THEME VALUE
  void changeTheme(int value) async{
    setValueThemeStorage(value);
    state = state.copyWith(
      valueTheme: value
    );
  }

}

// ! STATE
class ThemeValueState {
  
  final int valueTheme;

  ThemeValueState({
    this.valueTheme = 0,
  });


  ThemeValueState copyWith({
    int? valueTheme,
  }) => ThemeValueState(
      valueTheme: valueTheme ?? this.valueTheme,
  );
  
}
