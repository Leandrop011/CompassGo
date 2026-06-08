import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    FlutterNativeSplash.remove();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Home Screen'),
            SizedBox(width: 10,),
            Icon(Icons.explore_rounded)
          ],
        ),
      ),
      body: const Center(child: Text('Home Screnn'),),
    );
  }
}