import 'package:flutter/material.dart';

import 'package:wuphf_chat/models/models.dart';

class ViewProfileScreenArgs {
  final User user;
  ViewProfileScreenArgs({
    @required this.user,
  });
}

class ViewProfileScreen extends StatelessWidget {
  static const String routeName = '/view-profile-screen';

  static Route route({@required ViewProfileScreenArgs args}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ViewProfileScreen(user: args.user),
    );
  }

  const ViewProfileScreen({Key key, @required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.displayName),
      ),
    );
  }
}
