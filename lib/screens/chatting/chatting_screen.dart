import 'package:flutter/material.dart';

class ChattingScreen extends StatelessWidget {
  static const String routeName = '/chatting-screen';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ChattingScreen(),
    );
  }

  const ChattingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
