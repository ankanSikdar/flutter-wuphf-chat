import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/screens/screens.dart';
import 'package:wuphf_chat/screens/user_profile/widgets/widgets.dart';

class UserProfileScreen extends StatelessWidget {
  static const String routeName = '/user-profile-screen';

  const UserProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveUserBloc, LiveUserState>(
      builder: (context, state) {
        if (state.status == LiveUserStatus.loaded) {
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
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(16.0),
                children: [
                  UserHeader(
                    title: 'About',
                  ),
                  AboutContainer(
                    about: state.user.bio,
                  ),
                  UserHeader(
                    title: 'Settings',
                  ),
                  SettingsWidget(
                    name: 'Edit Profile',
                    icon: Icons.edit,
                    color: Colors.deepOrange[100],
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        EditProfileScreen.routeName,
                        arguments: EditProfileArgs(user: state.user),
                      );
                    },
                  ),
                  SettingsWidget(
                    name: 'App Details',
                    icon: Icons.info_outline,
                    color: Colors.deepPurple[100],
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppDetailsScreen.routeName);
                    },
                  ),
                  SignOutButton(),
                ],
              ),
            ),
          );
        }
        if (state.status == LiveUserStatus.error) {
          return Center(
            child: Text(state.error),
          );
        }
        return Center(child: LoadingIndicator());
      },
    );
  }
}
