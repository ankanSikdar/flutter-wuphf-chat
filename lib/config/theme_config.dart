import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConfig {
  static ThemeData themeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.amberAccent.shade700,
    accentColor: Colors.black,
    scaffoldBackgroundColor: Colors.grey[200],
    errorColor: Colors.red.shade900,
    textTheme: TextTheme().copyWith(
      headline3: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.w900,
        color: Colors.black,
      ),
      headline5: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
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
      subtitle1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.grey[600],
      ),
    ),
    fontFamily: GoogleFonts.nunitoSans().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 20.0,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.amberAccent.shade700,
    ),
  );

  static final userMessageColors = [
    Colors.deepOrange[100],
    Colors.orange[200],
  ];

  static final recipientMessageColors = [
    Colors.blue[200],
    Colors.deepPurple[100],
  ];

  static final messageTimeTextStyle = TextStyle(
    fontSize: 12,
    color: Colors.grey[800],
  );
}
