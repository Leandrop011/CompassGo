import 'package:animate_do/animate_do.dart';
import 'package:compass_app/features/compassGo/presentation/providers/sensors/sensors.dart';
import 'package:compass_app/features/compassGo/presentation/providers/themes_compass/themes_compass_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// ! WIDGET QUE DIBUJA EL COMPASS
class CompassWidget extends ConsumerStatefulWidget {
  // ? las emisiones del stream
  const CompassWidget({
    super.key, 
  });

  @override
  ConsumerState<CompassWidget> createState() => _CompassWidgetState();
}

class _CompassWidgetState extends ConsumerState<CompassWidget> {

  double prevValue = 0.0;
  double turns = 0;

  // ? METODO QUE DECIDIRA CUANTAS VUELTAS DAR SEGUN LOS DATOS(grados) DEL STREAM
  double getTurns( double heading ) {

    double? direction = heading;
    direction = (direction < 0) ? (360 + direction): direction;

    double diff = direction - prevValue;
    if(diff.abs() > 180) {

      if(prevValue > direction) {
        diff = 360 - (direction-prevValue).abs();
      } else {
        diff = 360 - (prevValue-direction).abs();
        diff = diff * -1;
      }
    }

    turns += (diff / 360);
    prevValue = direction;

    return turns * -1;
  }

  @override
  Widget build(BuildContext context) {

    final valuesCompass = ref.watch(compassProvider); 
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final getTheme = ref.watch(themesCompassProvider.notifier).getTheme();
    final colorTheme = Theme.of(context).colorScheme;

    return valuesCompass.when(
      data: (heading) {
        return FadeInDown(
          curve: Curves.elasticOut,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // * CONTIANER QUE MUESTRA LAS EMISIONES DE LAS ROTACIONES(STREAM)
              Container(
                width: size.width * 0.25,
                height: size.height * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black,
                  boxShadow:  [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 0.1, 
                      blurStyle: BlurStyle.normal,
                      color: colorTheme.primary.withOpacity(0.3),
                      offset: const Offset(1, 2)
                    )
                  ]
                ),
                child: Center(
                  child: Text(
                    '${heading!.toStringAsFixed(1)}°',
                    style: textTheme.titleMedium,
                  ),
                ),
              ),
          
              SizedBox(height: size.height * 0.05,),

              // * COMPASS
              Stack(
                alignment: Alignment.center,
                children: [
                
                // * Widget que tendra una rotacion de animacion segun valores del stream
                  AnimatedRotation(
                    turns: getTurns(heading), // * metodo TURNS 
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeOut,
                    child: SizedBox(
                      width: size.width * 0.85,
                      height: size.height * 0.3,
                      child: Image.asset(
                        width: double.infinity,
                        height: double.infinity,
                        getTheme.imageQuadrant,
                      ),
                    ),
                  ),

                SizedBox(
                  width: size.width * 0.2,
                  height: size.height * 0.15,
                  child: Image.asset(
                    width: double.infinity,
                    height: double.infinity,
                    getTheme.imageNeedle,
                  ),
                ),

                ],
              ),

              SizedBox(height: size.height * 0.03,),

              // * BOTON QUE NAVEGA A LA SCREEN PARA CAMBIAR EL TEMA DEL COMPASS
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FilledButton.icon(
                    onPressed: () {
                      context.push('config-theme-compass');
                      HapticFeedback.mediumImpact();
                    },
                    label: const Text('Temas'),
                    icon: const Icon(Icons.palette_rounded),
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))
                    ),
                  ),
                ),
              ),
            
            ],
          ),
        );
      }, 
      error: (error, stackTrace) => Text('Error en la carga, motivo: $error'), 
      loading: () => const Center(
        child: CircularProgressIndicator(strokeWidth: 5,),
      ),
    );
  }
}