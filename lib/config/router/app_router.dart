import 'package:compass_app/features/compassGo/presentation/presentation.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // * RUTAS
    // ? Ruta raiz
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    // ? Ruta de configuracion de la app
    GoRoute(
      path: '/config-app-screen',
      builder: (context, state) => const ConfigScreen(),
    ),
    // ? ruta de la configuracion tema del compass
    GoRoute(
      path: '/config-theme-compass',
      builder: (context, state) => const ThemesCompass(),
    ),
    // ? ruta de configuracion y visualizacion del map
    GoRoute(
      path: '/config-view-theme-map',
      builder: (context, state) => const MapFullScreen(),
    ),
    // ? ruta de configuracion del tema de la app 
    GoRoute(
      path: '/config-view-theme-app',
      builder: (context, state) => const ThemeAppScreen(),
    ),

  ]
);