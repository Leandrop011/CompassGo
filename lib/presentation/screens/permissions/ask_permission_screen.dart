import 'package:flutter/material.dart';

class AskPermissionScreen extends StatelessWidget {
  const AskPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permiso Requerido'),
      ),
    );
  }
}