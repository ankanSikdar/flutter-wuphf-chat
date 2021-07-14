import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/screens/user_profile/widgets/widgets.dart';

import 'bloc/userprofile_bloc.dart';

class UserProfileScreen extends StatelessWidget {
  static const String routeName = '/user-profile-screen';

  const UserProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        if (state.status == UserProfileStatus.loaded) {
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  UserAppBar(
                    displayName: state.user.displayName,
                    profileImageUrl: state.user.profileImageUrl,
                    email: state.user.email,
                  ),
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
                  SettingsWidget(),
                  SignOutButton(),
                ],
              ),
            ),
          );
        }
        if (state.status == UserProfileStatus.error) {
          return Center(
            child: Text(state.error),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
