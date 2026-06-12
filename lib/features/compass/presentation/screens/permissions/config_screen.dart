import 'package:compass_app/features/compass/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuraciones'),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.info_rounded)
          ),
        ],
      ),

      body: const _BodyView(),
    );
  }
}


class _BodyView extends ConsumerWidget {
  const _BodyView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final permissions = ref.watch(permissionProvider);
    final textTheme = Theme.of(context).textTheme;
    // final colorTheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsetsGeometry.only(left: size.width * 0.025),
      child: ListView(
      
        physics: const BouncingScrollPhysics(),
      
        children: [
      
          Padding(
            padding: EdgeInsetsGeometry.only(left: size.width * 0.01),
            child: Text(
              'Aplicacion',
              style: textTheme.titleLarge,
            ),
          ),
            
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
      
          Padding(
            padding: EdgeInsetsGeometry.only(top: size.height * 0.01, left: size.width * 0.01),
            child: Text(
              'Permisos',
              style: textTheme.titleLarge,
            ),
          ),
      
          BoxStyle(
            color: const Color.fromARGB(255, 64, 80, 96),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 0.5),
            height: size.height * 0.1,
            child: _CheckBoxTile(
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
            child: _CheckBoxTile(
              title: 'Sensores',          
              subTitle: 'Otorgar permisos de sensores.', 
              icon: Icons.sensors_rounded, 
              value: permissions.sensorsGranted,
              onChanged: () => ref.read(permissionProvider.notifier).requestPermissionSensors(), 
            ),
          ),

          SizedBox(height: size.height * 0.25,),

          FooterWidget(
            nameApp: 'CompassGo', 
            phrase: ' - Encuentra tu rumbo', 
            anio: '2026', 
            version: ' - v1.0.0', 
            size: size,
            textTheme: textTheme.bodyMedium ?? const TextStyle(),
            colorText: const Color.fromARGB(255, 117, 116, 116),
          ),
        ],
      ),
    );
  }
}

class _CheckBoxTile extends StatelessWidget {

  final String title;
  final String subTitle;
  final IconData icon;
  final VoidCallback onChanged;
  final bool value;

  const _CheckBoxTile({ 
    required this.title, 
    required this.subTitle, 
    required this.icon, 
    required this.onChanged, 
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(

      title: Text(title),
      subtitle: Text(subTitle),
      

      value: value, 
      onChanged: (_) => onChanged(),
    );
  }
}