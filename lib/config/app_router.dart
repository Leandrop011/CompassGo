
import 'package:compass_app/presentation/presentation.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // * RUTAS
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

  ]
);