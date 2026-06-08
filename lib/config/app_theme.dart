
import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarck;

  AppTheme({
    required this.isDarck
  });

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,

    colorSchemeSeed: Colors.purpleAccent,

    brightness: isDarck ? Brightness.dark : Brightness.light
  );
}