import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  static const String routeName = '/users-screen';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => UsersScreen(),
    );
  }

  const UsersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
