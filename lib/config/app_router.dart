
import 'package:compass_app/features/compass/presentation/presentation.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // * RUTAS
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/info-app-screen',
      builder: (context, state) => const InfoAppScreen(),
    ),
    GoRoute(
      path: '/config-app-screen',
      builder: (context, state) => const ConfigScreen(),
    ),

  ]
);