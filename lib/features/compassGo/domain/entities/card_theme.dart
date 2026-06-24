import 'package:compass_app/features/compassGo/presentation/providers/themes_compass/themes_compass_provider.dart';


class ThemeCard {
  final String title;
  final String subtitle;
  final String imageQuadrant;
  final String imageNeedle;
  final ThemesCompassTypes theme;

  ThemeCard({
    required this.title, 
    required this.subtitle, 
    required this.imageQuadrant, 
    required this.imageNeedle,
    required this.theme
  });
}