import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConfig {
  static ThemeData themeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.lightBlueAccent.shade700,
    accentColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    errorColor: Colors.red.shade900,
    textTheme: TextTheme().copyWith(
      headline3: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.w900,
        color: Colors.black,
      ),
      headline6: TextStyle(
        fontWeight: FontWeight.w600,
      ),
      bodyText1: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
      bodyText2: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    fontFamily: GoogleFonts.nunitoSans().fontFamily,
  );
}
