import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home-page";

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => HomeScreen(),
    );
  }

  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
