import 'package:flutter/material.dart';

class DevDetailsScreen extends StatelessWidget {
  static const routeName = '/dev-details-screen';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => DevDetailsScreen(),
    );
  }

  const DevDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
