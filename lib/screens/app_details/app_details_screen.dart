import 'package:flutter/material.dart';

class AppDetailsScreen extends StatelessWidget {
  static const String routeName = '/app-details-screen';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => AppDetailsScreen(),
    );
  }

  const AppDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
