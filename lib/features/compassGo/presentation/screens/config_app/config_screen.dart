import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:compass_app/features/compassGo/presentation/widgets/widgets.dart';
import '../../providers/providers.dart';

// ! SCREEN DE CONFIGURACIONES/PERMISOS DE LA APP
class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // final  colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuraciones'),
        centerTitle: true,
        actions: [
          // * Alert dialog de la informacion de la screen
          IconButton(
            onPressed: () => ShowDialogWidget.showDialogAlert(
              context, 
              'Informacion', 
              'Esta pantalla permite gestionar los permisos necesarios para el funcionamiento de la brújula y personalizar la apariencia de la aplicación.', 
              [
                FilledButton(
                  onPressed: () => context.pop(),
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                  ), 
                  child: const Text('Ok')
                )
              ],
            ), 
            icon: const Icon(Icons.info_rounded)
          ),
        ],
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_ios_new_rounded)),

      ),

      body: const _BodyView(),
    );
  }
}

// * BODY DE LA SCREEN CONFIG
class _BodyView extends ConsumerWidget {
  const _BodyView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final permissions = ref.watch(permissionProvider);
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final fountAppState = ref.watch(fountValueProvider);

    return Padding(
      padding: EdgeInsetsGeometry.only(left: size.width * 0.025),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          
          // * TITULO DE LAS CONFIGURACIONES DE LA APP
          Padding(
            padding: EdgeInsetsGeometry.only(left: size.width * 0.01),
            child: Row(
              children: [
                Text(
                  'Aplicacion',
                  style: textTheme.titleLarge,
                ),
                SizedBox(width: size.width * 0.02,),
                const Icon(CupertinoIcons.app_badge)
              ],
            ),
          ),
            
          // * CONFIGURACIONES DE LA APLICACION THEME/SECURITY
          BoxStyle(
            color: const Color.fromARGB(255, 50, 63, 76),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade700, width: 1),
            height: size.height * 0.1,
            width: size.width,
            child: SwitchListTile(
              title: Text('Fondo', style: textTheme.bodyLarge?.copyWith(color: Colors.white),),
              subtitle: Text('Obscuro/Blanco', style: textTheme.bodySmall?.copyWith(color: Colors.white),),
              secondary: const Icon(CupertinoIcons.moon_stars_fill, color: Colors.white,),
              value: fountAppState.fountValue, 
              onChanged: (value) => ref.read(fountValueProvider.notifier).changeFount(value),
            ),
          ),
      
          GestureDetector(
            onTap: () => context.push('config-view-theme-app'),
            child: BoxStyle(
              color: const Color.fromARGB(255, 50, 63, 76),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade700, width: 1),
              height: size.height * 0.1,
              width: size.width,
              child: ListTile(
                title: Text('Temas', style: textTheme.bodyLarge?.copyWith(color: Colors.white),),
                subtitle: Text('Personaliza la apariencia de la app', style: textTheme.bodySmall?.copyWith(color: Colors.white),),
                leading: const Icon(CupertinoIcons.paintbrush_fill, color: Colors.white,),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,),
              ),
            ),
          ),
      
          // * TITULO DE LA SECCION PERMISOS DE LA APP
          Padding(
            padding: EdgeInsetsGeometry.only(top: size.height * 0.01, left: size.width * 0.01),
            child: Row(
              children: [
                Text(
                  'Permisos',
                  style: textTheme.titleLarge,
                ),
                SizedBox(width: size.width * 0.02,),
                const Icon(CupertinoIcons.gear_solid)
              ],
            ),
          ),

          // * CHECKLIST DE LOS PERMISOS OTORGADOS O NO DE LA APP
          BoxStyle(
            color: const Color.fromARGB(255, 50, 63, 76),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade700, width: 1),
            height: size.height * 0.1,
            width: size.width,
            child: CheckBoxTile(
              title: 'Ubicacion', 
              subTitle: 'Otorgar permisos de ubicacion.', 
              icon: CupertinoIcons.location_north_fill, 
              value: permissions.locationGranted,
              onChanged: () => ref.read(permissionProvider.notifier).requestPermissionLocation(),
            ),
          ),
          
          // const SizedBox(height: 10,),
      
          BoxStyle(
            color: const Color.fromARGB(255, 50, 63, 76),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade700, width: 1),
            height: size.height * 0.1,
            width: size.width,
            child: CheckBoxTile(
              title: 'Sensores',          
              subTitle: 'Otorgar permisos de sensores.', 
              icon: CupertinoIcons.antenna_radiowaves_left_right, 
              value: permissions.sensorsGranted,
              onChanged: () => ref.read(permissionProvider.notifier).requestPermissionSensors(), 
            ),
          ),

          SizedBox(height: size.height * 0.25,),

          // * FOOTER DE LA APP
          FooterWidget(
            nameApp: 'CompassGo', 
            phrase: ' - Encuentra tu rumbo', 
            anio: '2026', 
            version: ' - v1.0.0', 
            size: size,
            textTheme: textTheme.headlineSmall?.copyWith(fontSize: size.width * 0.035) ?? const TextStyle(),
            colorText: const Color(0xFF666666),
          ),

          SizedBox(height: size.height * 0.1,),
        ],
      ),
    );
  }
}
