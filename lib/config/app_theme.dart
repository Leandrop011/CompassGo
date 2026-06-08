
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final bool isDarck;

  AppTheme({
    required this.isDarck
  });

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,

    colorSchemeSeed: Colors.purpleAccent,

    textTheme: TextTheme(
      titleLarge: GoogleFonts.googleSans()
        .copyWith(fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: -0.5),
      titleMedium: GoogleFonts.montserrat()
        .copyWith(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: -0.3),
      titleSmall: GoogleFonts.googleSans()
        .copyWith(fontSize: 15, letterSpacing: 0.1),
      bodyLarge: GoogleFonts.googleSans().copyWith(letterSpacing: 0.15),
      bodyMedium: GoogleFonts.saira().copyWith(letterSpacing: 0.1),
      bodySmall: GoogleFonts.roboto(fontWeight: FontWeight.normal, letterSpacing: 0.2),
    ),

    brightness: isDarck ? Brightness.dark : Brightness.light
  );
}