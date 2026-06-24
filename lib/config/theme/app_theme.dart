
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final bool isDarck;

  AppTheme({
    required this.isDarck
  });

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,

    colorSchemeSeed: Colors.blue,

    textTheme: TextTheme(
      // * TITULOS / DISPLAY -> Familia "Sora" (geometrica, tecnologica, ideal para una brujula)
      displayLarge: GoogleFonts.sora()
        .copyWith(fontSize: 34, fontWeight: FontWeight.w800, letterSpacing: -1.0),
      displayMedium: GoogleFonts.sora()
        .copyWith(fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.8),

      headlineMedium: GoogleFonts.sora()
        .copyWith(fontSize: 25, fontWeight: FontWeight.w700, letterSpacing: -0.5),

      // * TITULOS DE SECCION ("Aplicacion", "Permisos")
      titleLarge: GoogleFonts.spaceGrotesk()
        .copyWith(fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.4),
      // * GRADOS DE LA BRUJULA / "Permisos Necesarios"
      titleMedium: GoogleFonts.spaceGrotesk()
        .copyWith(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 0.2),
      titleSmall: GoogleFonts.spaceGrotesk()
        .copyWith(fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.1),

      // * CUERPO DE TEXTO -> Familia "Rubik" (limpia y muy legible)
      bodyLarge: GoogleFonts.rubik()
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      bodyMedium: GoogleFonts.rubik()
        .copyWith(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 1.4),
      bodySmall: GoogleFonts.rubik()
        .copyWith(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.3),

      // * ETIQUETAS / BOTONES
      labelLarge: GoogleFonts.spaceGrotesk()
        .copyWith(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      labelMedium: GoogleFonts.rubik()
        .copyWith(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5),
      labelSmall: GoogleFonts.rubik()
        .copyWith(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5),
    ),

    brightness: isDarck ? Brightness.dark : Brightness.light
  );
}