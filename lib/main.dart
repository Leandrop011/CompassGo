import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

import 'package:compass_app/config/config.dart';

void main() async{
  // !  SECCION 02 - PERMISOS(PERMISSION HANDLER)
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
  ]);

  runApp( 
    const ProviderScope(
      child: MainApp()
    )
  );

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {


    return MaterialApp.router(
      theme: AppTheme(isDarck: true).getTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
