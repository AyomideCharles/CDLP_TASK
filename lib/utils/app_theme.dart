import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final light = ThemeData(
    brightness: Brightness.light,
    textTheme: GoogleFonts.openSansTextTheme(ThemeData.light().textTheme),
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
    ),
    useMaterial3: true,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    textTheme: GoogleFonts.openSansTextTheme(ThemeData.light().textTheme),
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Colors.white,
      onSecondary: Colors.black,
      surface: Colors.black,
      onSurface: Colors.white,
      error: Colors.red,
      onError: Colors.black,
    ),
    useMaterial3: true,
  );
}
