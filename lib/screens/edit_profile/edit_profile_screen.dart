import 'package:flutter/material.dart';
import 'package:wuphf_chat/models/models.dart';

class EditProfileArgs {
  final User user;

  EditProfileArgs({@required this.user});
}

class EditProfileScreen extends StatelessWidget {
  static const String routeName = '/edit-profile-screen';

  static Route route({@required EditProfileArgs args}) {
    print('Args: ${args.user.displayName}');
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
