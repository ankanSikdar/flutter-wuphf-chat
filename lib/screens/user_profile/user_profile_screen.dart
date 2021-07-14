import 'package:flutter/material.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/repositories/user/user_repository.dart';
import 'package:wuphf_chat/screens/user_profile/widgets/widgets.dart';

class UserProfileScreen extends StatelessWidget {
  static const String routeName = '/user-profile-screen';

  const UserProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            UserAppBar(),
          ];
        },
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            UserHeader(
              title: 'About',
            ),
            AboutContainer(),
            UserHeader(
              title: 'Settings',
            ),
            ElevatedButton.icon(
                icon: Icon(Icons.exit_to_app),
                label: Text('Sign Out'),
                onPressed: () {
                  context.read<AuthBloc>().add(AuthUserLogOut());
                })
          ],
        ),
      ),
    );
  }
}
