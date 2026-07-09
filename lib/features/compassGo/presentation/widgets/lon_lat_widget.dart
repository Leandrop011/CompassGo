import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:compass_app/features/compassGo/presentation/providers/providers.dart';
import 'package:compass_app/features/compassGo/presentation/widgets/widgets.dart';

// ! WIDGET QUE CONTRUYE LOS DATOS DE LA LONGITUD Y LATITUD DEL USER Y LE DA LA OPCION DE VISUALIZARLA EN EL MAP

class LonLatWidget extends ConsumerWidget {
  const LonLatWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final latLongValues$ = ref.watch(watchLocationProvider);
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    return latLongValues$.when(
      data: (data) => GestureDetector(
        onDoubleTap: () {
          context.push('config-view-theme-map');

          // ? para guiar al user en su ubicacion by lat and long, y agregar un marker
          Future.delayed(const Duration(milliseconds: 2500), () {
            ref.read(mapControllerProvider.notifier).addMarkerCurrentPosition('Tu ubicacion');
            ref.read(mapControllerProvider.notifier).findUser();
          },);

          HapticFeedback.mediumImpact();
        },
        child: _LonLatWidget(
          size: size, 
          textTheme: textTheme, 
          latValue: data.$1, 
          lonValue: data.$2,
          colorTheme: colorTheme,
        ),
      ), 
      error: (error, stackTrace) => Text('Error: $error'), 
      loading: () => const Center(child: CircularProgressIndicator( strokeWidth: 4, )),
    );
  }
}

// * WIDGET QUE SE CONSTRUYE CUANDO OBTENEMOS LA DATA DE LA LONG Y LAT
class _LonLatWidget extends ConsumerWidget {
  final Size size;
  final TextTheme textTheme;
  final double latValue;
  final double lonValue; 
  final ColorScheme colorTheme;

  const _LonLatWidget({
    required this.size,
    required this.textTheme, 
    required this.latValue, 
    required this.lonValue, 
    required this.colorTheme,
  });


  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      height: size.height * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(CupertinoIcons.globe, color: colorTheme.primary, size: size.width * 0.135,),

          SizedBox(height: size.height * 0.01,),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              BoxStyle(
                height: size.height * 0.06, 
                width: size.width * 0.3,
                color: Colors.black, 
                borderRadius: BorderRadius.circular(15), 
                border: Border.all(width: 2, color: colorTheme.primary.withOpacity(0.6)),
                child: Center(child: Text('Long.', style: textTheme.labelLarge?.copyWith(color: Colors.white),)),
              ),
              SizedBox(width: size.width * 0.01,),
              BoxStyle(
                height: size.height * 0.06, 
                width: size.width * 0.3,
                color: Colors.black, 
                borderRadius: BorderRadius.circular(15), 
                border: Border.all(width: 2, color: colorTheme.primary.withOpacity(0.6)),
                child: Center(child: Text('Lat.', style: textTheme.labelLarge?.copyWith(color: Colors.white),)),
              ),
      
            ],
          ),
      
          SizedBox(height: size.height * 0.005,),
          Divider(
            indent: size.width * 0.1,
            endIndent: size.width * 0.1,
            thickness: size.height * 0.003,
            radius: BorderRadius.circular(10),
          ),
          SizedBox(height: size.height * 0.005,),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BoxStyle(
                height: size.height * 0.1, 
                width: size.width * 0.3,
                color: colorTheme.primary.withOpacity(0.15), 
                borderRadius: BorderRadius.circular(15), 
                border: Border.all(width: 2, color: Colors.white30),
                child: Center(child: Text(lonValue.toStringAsFixed(5), style: textTheme.bodyMedium?.copyWith(color: Colors.white),)),
              ),
              SizedBox(width: size.width * 0.01,),
              BoxStyle(
                height: size.height * 0.1, 
                width: size.width * 0.3,
                color: colorTheme.primary.withOpacity(0.15), 
                borderRadius: BorderRadius.circular(15), 
                border: Border.all(width: 2, color: Colors.white30),
                child: Center(child: Text(latValue.toStringAsFixed(5), style: textTheme.bodyMedium?.copyWith(color: Colors.white),)),
              ),
            ],
          ),
      
          SizedBox(height: size.height * 0.03),
      
          Align(
            alignment: Alignment.bottomCenter,
            child: FilledButton.icon(
              onPressed: () async{
                context.push('config-view-theme-map');

                await Future.delayed(const Duration(milliseconds: 2500), () {
                  ref.read(mapControllerProvider.notifier).addMarkerCurrentPosition('Tu ubicacion');
                  ref.read(mapControllerProvider.notifier).findUser();
                },);

                HapticFeedback.mediumImpact();
              }, 
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10)
                )
              ),
              label: const Text('Ver en el mapa'),
              icon: const Icon(CupertinoIcons.map_fill),
            ),
          ),
      
          SizedBox(height: size.height * 0.03),
        ],
      ),
    );
  }
}