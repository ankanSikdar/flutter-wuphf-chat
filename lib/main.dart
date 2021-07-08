import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wuphf_chat/screens/signup/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wuphf Chat',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlueAccent.shade700,
        accentColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
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
        ),
        fontFamily: GoogleFonts.nunitoSans().fontFamily,
      ),
      initialRoute: SignUpScreen.routeName,
      routes: {
        SignUpScreen.routeName: (context) => SignUpScreen(),
      },
    );
  }
}
