import 'package:compass_app/domain/domain.dart';
import 'package:flutter/material.dart';

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

final List<Permission> permissions = [
  Permission(title: 'Ubicacion', subTitle: 'Conceder el permiso a la ubicacion', value: false, onChanged: () {}, icon: Icons.explore),
  Permission(title: 'Sensores', subTitle: 'Conceder el permiso a los sensores', value: false, onChanged: () {}, icon: Icons.explore),
];

class _BodyView extends StatelessWidget {
  const _BodyView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: permissions.map(
        (permission) => _PermissionTile(
          title: permission.title, 
          subTitle: permission.subTitle, 
          icon: permission.icon, 
          onChanged: permission.onChanged, 
          value: permission.value
        )
      ).toList(),
    );
  }
}

class _PermissionTile extends StatelessWidget {

  final String title;
  final String subTitle;
  final IconData icon;
  final VoidCallback onChanged;
  final bool value;

  const _PermissionTile({ 
    required this.title, 
    required this.subTitle, 
    required this.icon, 
    required this.onChanged, 
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(

      title: Text(title),
      subtitle: Text(subTitle),

      value: value, 
      onChanged: (value) => onChanged(),
    );
  }
}