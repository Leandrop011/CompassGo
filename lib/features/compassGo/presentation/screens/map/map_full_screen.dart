import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:compass_app/features/compassGo/presentation/widgets/widgets.dart';
import 'package:compass_app/features/compassGo/presentation/providers/providers.dart';

class MapFullScreen extends ConsumerWidget {

  const MapFullScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final size = MediaQuery.of(context).size;
    final themesMap = ref.watch(themesMapProvider.notifier).listThemesMap();
    final colorTheme = Theme.of(context).colorScheme;
    final controllerMap = ref.watch(mapControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla Completa'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => ShowDialogWidget.showDialogAlert(
              context, 
              'Informacion', 
              'En esta pantalla se muestra el mapa en pantalla completa. Puedes interactuar con el mapa, hacer zoom y ver tu ubicación actual, ademas cambiar el tipo de mapa.', 
              [
                FilledButton(
                  onPressed: () => context.pop(),
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    )
                  ), 
                  child: const Text('Ok'),
                ),
              ]
            ), 
            icon: const Icon(Icons.info_rounded)
          ),
        ],
      
        leading: IconButton(
          onPressed: () => context.pop(), 
          icon: const Icon(Icons.arrow_back_ios_new_rounded)
        ),
      ),

      body: SafeArea(
        child: Stack(
          children: [
            
            // ? widget del map
            const MapWidget( ),
          
            // ? widget de un dropdownmenu
            Positioned(
              top: size.height * 0.01,
              left: size.width * 0.02,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: DropMenuWidget(
                  colorTheme: colorTheme, 
                  themesMap: themesMap, 
                  themesMapProvider: themesMapProvider
                ),
              ),
            ),

            // ? BOTONES DE CONTROL DEL MAPA
            Positioned(
              top: size.height * 0.08,
              left: size.width * 0.025,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  FilledButtonWidget(
                    label: 'Centrar', 
                    onPressed: () {
                      ref.read(mapControllerProvider.notifier).findUser();
                      HapticFeedback.mediumImpact();
                    }, 
                    icon: Icons.location_searching_rounded,
                  ),
                  FilledButtonWidget(
                    label: (controllerMap).followUser ? 'Siguiendo' : 'Estatico', 
                    onPressed: () {
                      ref.read(mapControllerProvider.notifier).toggleFolowUser();
                      HapticFeedback.mediumImpact();
                    }, 
                    icon: (controllerMap).followUser ?
                    Icons.directions_run_rounded
                    : 
                    Icons.accessibility_new_outlined, // * case when is not active
                  ),
                  FilledButtonWidget(
                    label: 'Marker', 
                    onPressed: () {
                      ref.read(mapControllerProvider.notifier).addMarkerCurrentPosition('Marker');
                      HapticFeedback.mediumImpact();
                    },
                    icon: Icons.location_pin,
                  ),
              
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}