import 'package:compass_app/features/shared/infrastructure/infraestructure.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const keyStorageMap = 'key-map-theme';

// ! PROVIDER 
final themesMapProvider  = StateNotifierProvider<ThemesMapNotifier, ThemesMapState>((ref) {
  final themeMapStorageServiceImpl = ThemeMapStorageServiceImpl();
  return ThemesMapNotifier( themeMapStorageService: themeMapStorageServiceImpl );
});

// ! NOTIFIER
class ThemesMapNotifier extends StateNotifier<ThemesMapState> {

  final ThemeMapStorageService themeMapStorageService;

  ThemesMapNotifier({
    required this.themeMapStorageService
  }): super(ThemesMapState()){
    getValueTheme();
  }

  // * METODO QUE RETORNA LA LISTA DE THEMES
  List<MapType> listThemesMap(){
    return MapType.values.map(
      (theme) => theme
    ).toList();
  }

  // * METODO QUE CAMBIA EL THEME
  void changeThemeMap(MapType type){
    state = state.copyWith(
      typeMap: type,
      selectedTypeValue: type.index
    );
  }
  
  // * METODO QUE OBTIENE EL VALUE DEL THEME GUARDADO IN LOCAL STORAGE
  void getValueTheme() async{
    final value = await themeMapStorageService.getValueThemeMap(keyStorageMap);

    state = state.copyWith(
      selectedTypeValue: value,
      typeMap: listThemesMap()[value]
    );
  }

  // * METODO QUE GUARDA EL VALUE DEL THEME IN LOCAL STORAGE
  void setValueTheme( int value ) async{
    await themeMapStorageService.setValueThemeMap(keyStorageMap, value);

    state = state.copyWith(
      selectedTypeValue: value,
      typeMap: MapType.values[value]
    );

  }

}

// ! STATE
class ThemesMapState {
  final MapType typeMap;
  final int selectedTypeValue;

  ThemesMapState({
    this.typeMap = MapType.normal, 
    this.selectedTypeValue = 0,
  });
  

  ThemesMapState copyWith({
    MapType? typeMap,
    int? selectedTypeValue,
  }) => ThemesMapState(
      typeMap: typeMap ?? this.typeMap,
      selectedTypeValue: selectedTypeValue ?? this.selectedTypeValue,
  );
}
