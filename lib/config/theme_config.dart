import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConfig {
  static ThemeData themeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.amberAccent.shade700,
    accentColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    errorColor: Colors.red.shade900,
    hintColor: Colors.grey[600],
    textTheme: TextTheme().copyWith(
      headline3: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.w900,
        color: Colors.black,
      ),
      headline4: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 36,
        color: Colors.black,
      ),
      headline5: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: Colors.black,
      ),
      headline6: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w900,
        color: Colors.black,
      ),
      subtitle1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.grey[600],
      ),
      subtitle2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.grey[600],
      ),
      bodyText1: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18.0,
        color: Colors.black,
      ),
      button: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
        color: Colors.black,
      ),
      overline: TextStyle(
        fontSize: 12.0,
        color: Colors.grey[800],
        letterSpacing: 0.5,
        fontWeight: FontWeight.w700,
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

  static const borderRadius = 15.0;
  static const dpRadius = 125.0;
  static const smallDpRadius = 35.0;

  static final chattingScreenScaffoldBackgroundColor = Colors.grey[200];
}






// class ThemeConfig {
//   static ThemeData themeData = ThemeData(
//     brightness: Brightness.light,
//     primaryColor: Colors.amberAccent.shade700,
//     accentColor: Colors.black,
//     scaffoldBackgroundColor: Colors.white,
//     errorColor: Colors.red.shade900,
//     textTheme: TextTheme().copyWith(
//         headline3: TextStyle(
//           fontSize: 50,
//           fontWeight: FontWeight.w900,
//           color: Colors.black,
//         ),
//         headline4: TextStyle(
//           fontWeight: FontWeight.w900,
//           fontSize: 22,
//           color: Colors.black,
//         ),
//         headline5: TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.w800,
//           color: Colors.black,
//         ),
//         headline6: TextStyle(
//           fontWeight: FontWeight.w600,
//         ),
//         bodyText1: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 16.0,
//         ),
//         bodyText2: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//         subtitle1: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//           color: Colors.grey[600],
//         ),
//         subtitle2: TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//           color: Colors.grey[600],
//         )),
//     fontFamily: GoogleFonts.nunitoSans().fontFamily,
//     bottomNavigationBarTheme: BottomNavigationBarThemeData(
//       elevation: 20.0,
//       backgroundColor: Colors.white,
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: Colors.amberAccent.shade700,
//     ),
//   );

//   static final userMessageColors = [
//     Colors.deepOrange[100],
//     Colors.orange[200],
//   ];

//   static final recipientMessageColors = [
//     Colors.blue[200],
//     Colors.deepPurple[100],
//   ];

//   static final messageTimeTextStyle = TextStyle(
//     fontSize: 12,
//     color: Colors.grey[800],
//   );

//   static final chattingScreenScaffoldBackgroundColor = Colors.grey[200];
// }
