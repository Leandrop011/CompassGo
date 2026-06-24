
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


  const SlideView({super.key,  
    required this.title, 
    required this.widget, 
    this.subTitle, 
    this.icons, 
    required this.size, 
  });

  @override
  Widget build(BuildContext context, ref) {

    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    final valuePermissionLocation = ref.watch(permissionProvider).locationGranted;
    final valuePermissionSensors = ref.watch(permissionProvider).sensorsGranted;

    return GestureDetector(
      onDoubleTap: () {
        // TODO: EN FUTURAS IMPLEMENTACION, ESTO CAMBIARA A UNA FUNCION 
        context.push('config-theme-compass');
        HapticFeedback.vibrate();
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            // * TITULO DEL SLIDE
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                width: size.width * 0.75,
                height: size.height * 0.07, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black45,  
                  border: Border.all(width: size.width * 0.0035, color: Colors.white12),
                ),
                child: Center(
                  child: Text(
                    title, 
                    style: textTheme.bodyMedium?.copyWith(fontSize: size.width * 0.06),
                  ),
                ),
              ),
            ),
      
            const SizedBox(height: 10,), 
      
            // * SLIDE
            Container(
              width: size.width * 0.85,
              height: size.height * 0.58,
              decoration: BoxDecoration(
                color: Colors.black87,
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
            ),  
          ],
        ),
      ),
    );
  }
}