import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final light = ThemeData(
    brightness: Brightness.light,
    textTheme: GoogleFonts.robotoTextTheme(ThemeData.light().textTheme),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Colors.black,
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      surfaceBright: Color(0xFFF5F5F5),
    ),
    useMaterial3: true,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme),
    scaffoldBackgroundColor: Color(0xFF1C1C1E),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Colors.white,
      onSecondary: Colors.black,
      surface: Color(0xFF1C1C1E),
      onSurface: Colors.white,
      error: Colors.red,
      onError: Colors.black,
      surfaceBright: Color(0xFF424242),
    ),
    useMaterial3: true,
  );
}
