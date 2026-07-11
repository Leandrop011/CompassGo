
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../providers/providers.dart';

// ! WIDGET SLIDE
class SlideView extends ConsumerWidget {

  final String title;
  final Widget widget;
  final String? subTitle;
  final IconData? icons;
  final Size size;
  final String routeConfiguration;


  const SlideView({
    super.key,  
    required this.title, 
    required this.widget, 
    this.subTitle, 
    this.icons, 
    required this.size, 
    required this.routeConfiguration, 
  });

  @override
  Widget build(BuildContext context, ref) {

    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    final valuePermissionLocation = ref.watch(permissionProvider).locationGranted;
    final valuePermissionSensors = ref.watch(permissionProvider).sensorsGranted;

    return GestureDetector(
      onDoubleTap: () {
        
        if(routeConfiguration == '/'){
          return;
        }
        context.push(routeConfiguration);

        HapticFeedback.vibrate();
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            // * TITULO DEL SLIDE
            _TitleView(size: size, title: title, textTheme: textTheme, colorTheme: colorTheme,),
      
            const SizedBox(height: 10,), 
      
            // * SLIDE
            _SlideView(size: size, colorTheme: colorTheme, valuePermissionSensors: valuePermissionSensors, valuePermissionLocation: valuePermissionLocation, widget: widget, textTheme: textTheme),  
          ],
        ),
      ),
    );
  }
}

// * WIDGET QUE CONSTRUYE EL TITLE DE CADA SLIDE
class _TitleView extends ConsumerWidget {
  final Size size;
  final String title;
  final TextTheme textTheme;
  final ColorScheme colorTheme;
  
  const _TitleView({
    required this.size,
    required this.title,
    required this.textTheme, 
    required this.colorTheme,
  });


  @override
  Widget build(BuildContext context, ref) {
    final fountValueState = ref.watch(fountValueProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: size.width * 0.75,
        height: size.height * 0.07, 
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: (fountValueState.fountValue) ? Colors.black45 : const Color.fromARGB(221, 22, 22, 22),  
          border: Border.all(width: size.width * 0.0035, color: Colors.white12 ),
        ),
        child: Center(
          child: Text(
            title, 
            style: textTheme.bodyMedium?.copyWith(fontSize: size.width * 0.06, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// * WIDGET OF SLIDE
class _SlideView extends ConsumerWidget {
  const _SlideView({
    required this.size,
    required this.colorTheme,
    required this.valuePermissionSensors,
    required this.valuePermissionLocation,
    required this.widget,
    required this.textTheme,
  });

  final Size size;
  final ColorScheme colorTheme;
  final bool valuePermissionSensors;
  final bool valuePermissionLocation;
  final Widget widget;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context, ref) {
    final fountValueState = ref.watch(fountValueProvider);
    return Container(
      width: size.width * 0.85,
      height: size.height * 0.58,
      decoration: BoxDecoration(
        color: (fountValueState.fountValue) ? Colors.black87 : Colors.grey.shade900,
        border: Border.all(color: colorTheme.primary.withOpacity(0.7), width: size.width * 0.005),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: colorTheme.primary, // Color de la sombra
            spreadRadius: 1,                     // Qué tanto se expande
            blurRadius: 20,       
            blurStyle: BlurStyle.normal,                // Nivel de desenfoque
            offset: const Offset(1, 1), 
          )
        ]
      ),
          
      // * VERIFICACION PERVIA A MOSTRAR EL WIDGET QUE SE PROVEEA
      child: (valuePermissionSensors && valuePermissionLocation) ? 
        Padding(
          padding: EdgeInsetsGeometry.all(size.width * 0.02),
          child: widget,
        ) // ? caso en el que los permisos estan otorgados
        :
        Column( // ? caso en que los permisos estan no otorgados/denegados
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Lottie.asset( 
              width: size.width * 0.6, 
              height: size.height * 0.2, 
              'assets/animations/permissions.json'
            ),
          
            Text('Permisos necesarios', style: textTheme.titleMedium,),
            const SizedBox(height: 10,),
            FilledButton(
              onPressed: () => ref.read(permissionProvider.notifier).requestBothPermissions(),
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10)
                )
              ), 
              child: const Text('Permitir',),
            )
          ],
        ),
    );
  }
}