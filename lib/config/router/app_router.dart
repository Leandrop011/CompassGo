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
    // ? Ruta info app
    GoRoute(
      path: '/info-app-screen',
      builder: (context, state) => const InfoAppScreen(),
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

  ]
);