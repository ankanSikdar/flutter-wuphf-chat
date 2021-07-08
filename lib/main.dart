import 'package:flutter/material.dart';

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
        primarySwatch: Colors.lightBlueAccent[300],
        accentColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(),
    );
  }
}
