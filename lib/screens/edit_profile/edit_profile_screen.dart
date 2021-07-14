import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  static const String routeName = '/edit-profile-screen';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => EditProfileScreen(),
    );
  }

  const EditProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
    );
  }
}
