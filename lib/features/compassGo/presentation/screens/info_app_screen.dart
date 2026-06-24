import 'package:flutter/material.dart';

// ! SCREEN DE INFORMACION DE LA APP
class InfoAppScreen extends StatelessWidget {
  const InfoAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Screen'),
      ),
    );
  }
}