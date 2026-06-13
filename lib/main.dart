import 'package:compass_app/features/compass/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

import 'package:compass_app/config/config.dart';

void main() async{
  // !  SECCION 03 - COMPASS PAGEVIEW
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

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

// * MIXIN NECESARIO PARA EXCUCHAR EVENTO EN TERMINATED-BACKGROUND
class _MainAppState extends ConsumerState<MainApp> with WidgetsBindingObserver{

  // * CONFIGURACIONES PARA QUE SI LOS CAMBIOS SE REALIZAN 
  // * EN EL BACKGROUND O TERMINATED, REALICE LOS CAMBIOS AL VOLVER A LA APP
  @override
  void initState() {
    super.initState();
    // ? OBSERVADOR DEL STATE DE LA APP
    WidgetsBinding.instance.addObserver(this);

    ref.read(permissionProvider.notifier).checkPermissions();

  }

  // ? LO QUE REALIZA ESTO ES QUE NOTIFICA CUANDO EL ESTADO DE LA APP CAMBIA
  @override
  void didChangeAppLifecycleState( AppLifecycleState state ) {

    // * cambia el state de la app(para redibujar)
    ref.read(appStateProvider.notifier).state = state;

    // * si vuelve a la app, vuelve a verificar los permisos
    if( state == AppLifecycleState.resumed ){
      ref.read(permissionProvider.notifier).checkPermissions();
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return MaterialApp.router(
      theme: AppTheme(isDarck: true).getTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
