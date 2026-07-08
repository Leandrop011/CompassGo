import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../providers/providers.dart';

// ! WIDGET QUE CONSTRUYE UN DROPDOWN MENU
class DropMenuWidget extends ConsumerWidget {

  final ColorScheme colorTheme;
  final List<MapType> themesMap;
  final StateNotifierProvider<ThemesMapNotifier, ThemesMapState> themesMapProvider;

  const DropMenuWidget({
    super.key, 
    required this.colorTheme, 
    required this.themesMap, 
    required this.themesMapProvider
  });

  @override
  Widget build(BuildContext context, ref) {

    // * WIDGET DROPDOWNMENU
    return  DropdownMenu(    
      // * ESTILOS 
      textStyle: TextStyle(
        color: colorTheme.primary
      ),
    
      
    
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      
      // * EL VALUE DE INICIO
      initialSelection: themesMap[ref.read(themesMapProvider).selectedTypeValue],

      // * LIST DE TODOS LOS TYPES DE THEMES MAP
      dropdownMenuEntries: themesMap.map<DropdownMenuEntry<MapType>>(
        (MapType value) {
          return DropdownMenuEntry<MapType>(
            value: value, // ? el value que posee by la list del provider 
            label: value.name.toUpperCase() // ? y el texto que posee 
          );
        }
      ).toList(),
    
      // * EMTODO ONSELECTED QUE DISPARA UN METODO QUE CAMBIA EL THEME Y GUARDA EL VALUE DEL THEME LOCALMENTE
      onSelected: (value) async{
        ref.read(themesMapProvider.notifier).changeThemeMap(value ?? MapType.normal);
        ref.read(themesMapProvider.notifier).setValueTheme(value?.index ?? 1);

        HapticFeedback.mediumImpact();
      },
    );
  }
}