import 'package:compass_app/features/compassGo/domain/domain.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../shared/shared.dart';


const keyThemeComassStorage = 'theme-compass';

// ! PROVIDER
final themesCompassProvider = StateNotifierProvider<ThemesCompassNotifier, ThemesCompassState>((ref) {
  
  final themeCompassStorageService = ThemeValueStorageServiceImpl();

  return ThemesCompassNotifier(themeValueStorageService: themeCompassStorageService);
});



// ! NOTIFIER
class ThemesCompassNotifier extends StateNotifier<ThemesCompassState> {

  final ThemeValueStorageService themeValueStorageService;

  ThemesCompassNotifier({
    required this.themeValueStorageService
  }): super(ThemesCompassState()){
    getValueThemeStorage();
  }

  // * METODO QUE CAMBIA EL TEMA DE UNA APLICACION
  void changeTheme (int value, {ThemesCompassTypes? valueTheme}) async{
    
    final themeChose = themesCompass()[value];

    state = state.copyWith(
      quadrant: themeChose.imageQuadrant,
      needle: themeChose.imageNeedle,
      theme: valueTheme
    );

  }

  // * METODO QUE DEVUELVE UN THEMECARD, DEPENDIENDO DEL VALUETHEME(GUARDADO LOCALMENTE)
  ThemeCard getTheme() {
    final getValueTheme = state.valueTheme;
    return themesCompass()[getValueTheme];
  }

  // * METODO QUE ESTABLECE EL VALOR DEL THEME COMPASS LOCALMENTE
  void setValueThemeStorage(int value) async{
    await themeValueStorageService.setValueThemeCompass(keyThemeComassStorage, value);

    state = state.copyWith(valueTheme: value);
  }

  // * METODO QUE OBTIENE EL VALOR DEL THEME COMPASS LOCALMENTE
  Future<int> getValueThemeStorage() async{
    final value = await themeValueStorageService.getValueThemeCompass(keyThemeComassStorage);

    final type = ThemesCompassTypes.values.firstWhere((type) => type.index == value);

    // ? redibuja el state, dependiendo del value LOCAL obtenido
    state = state.copyWith(
      valueTheme: value,
      theme: type,
    );

    return value;
  }

  // * METODO QUE DEVUELVE LA CANTIDAD DE TEMAS EXISTENTES
  List<ThemeCard> themesCompass(){

    final List<ThemeCard> themesCompass = [];
    
    for (var i = 0; i < 13; i++) {
      themesCompass.add(
        ThemeCard(
          title: 'Tema ${i + 1}', 
          subtitle: '', 
          imageQuadrant: 'assets/images/compass_images/quadrant-${i + 1}.png', 
          imageNeedle: 'assets/images/compass_images/needle-${i+1}.png', 
          theme: ThemesCompassTypes.values.byName('theme${i + 1}') // * BUSQUEDA CON BYNAME, RETORNO PRIMERA COINCIDENCIA
        )
      );
    }

    return themesCompass; 

  }
  
}

// ? ENUMERACION DE LOS TEMAS
enum ThemesCompassTypes {
  theme1, 
  theme2, 
  theme3, 
  theme4, 
  theme5, 
  theme6, 
  theme7, 
  theme8, 
  theme9,
  theme10,
  theme11,
  theme12,
  theme13,
}

// ! STATE
class ThemesCompassState {
  final ThemesCompassTypes theme;
  final String quadrant;
  final String needle;
  final int valueTheme;

  ThemesCompassState({
    this.theme = ThemesCompassTypes.theme1, 
    this.quadrant = 'assets/images/compass_images/quadrant-1.png', 
    this.needle = 'assets/images/compass_images/needle-1.png', 
    this.valueTheme = 0,
  });

  ThemesCompassState copyWith({
    ThemesCompassTypes? theme,
    String? quadrant,
    String? needle,
    int? valueTheme,
  }) => ThemesCompassState(
      theme: theme ?? this.theme,
      quadrant: quadrant ?? this.quadrant,
      needle: needle ?? this.needle,
      valueTheme: valueTheme ?? this.valueTheme,
  );
}
