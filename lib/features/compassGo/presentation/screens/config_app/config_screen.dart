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
                  child: const Text('Ok')
                )
              ],
            ), 
            icon: const Icon(Icons.info_rounded)
          ),
        ],
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

    return Padding(
      padding: EdgeInsetsGeometry.only(left: size.width * 0.025),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          
          // * TITULO DE LAS CONFIGURACIONES DE LA APP
          Padding(
            padding: EdgeInsetsGeometry.only(left: size.width * 0.01),
            child: Text(
              'Aplicacion',
              style: textTheme.titleLarge,
            ),
          ),
            
          // * CONFIGURACIONES DE LA APLICACION THEME/SECURITY
          BoxStyle(
            color: const Color.fromARGB(255, 64, 80, 96),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 0.5),
            height: size.height * 0.1,
            child: SwitchListTile(
              title: const Text('Fondo'),
              subtitle: const Text('Obscuro/Blanco'),
              value: false, 
              onChanged: (value) => {},
            ),
          ),
      
          BoxStyle(
            color: const Color.fromARGB(255, 64, 80, 96),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 0.5),
            height: size.height * 0.1,
            child: SwitchListTile(
              title: const Text('Seguridad'),
              subtitle: const Text('PIN/Biometricos'),
              value: false,
              onChanged: (value) => {},
            ),
          ),
      
          // * TITULO DE LA SECCION PERMISOS DE LA APP
          Padding(
            padding: EdgeInsetsGeometry.only(top: size.height * 0.01, left: size.width * 0.01),
            child: Text(
              'Permisos',
              style: textTheme.titleLarge,
            ),
          ),

          // * CHECKLIST DE LOS PERMISOS OTORGADOS O NO DE LA APP
          BoxStyle(
            color: const Color.fromARGB(255, 64, 80, 96),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 0.5),
            height: size.height * 0.1,
            child: CheckBoxTile(
              title: 'Ubicacion', 
              subTitle: 'Otorgar permisos de ubicacion.', 
              icon: Icons.explore, 
              value: permissions.locationGranted,
              onChanged: () => ref.read(permissionProvider.notifier).requestPermissionLocation(),
            ),
          ),
          
          // const SizedBox(height: 10,),
      
          BoxStyle(
            color: const Color.fromARGB(255, 64, 80, 96),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 0.5),
            height: size.height * 0.1,
            child: CheckBoxTile(
              title: 'Sensores',          
              subTitle: 'Otorgar permisos de sensores.', 
              icon: Icons.sensors_rounded, 
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
