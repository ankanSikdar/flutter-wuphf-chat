import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';

import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/screens/chatting/chatting_screen.dart';
import 'package:wuphf_chat/screens/screens.dart';
import 'package:wuphf_chat/screens/users/bloc/users_bloc.dart';

class UsersScreen extends StatelessWidget {
  static const String routeName = '/users-screen';

  // Dont need this since the UsersScreen is created through NavScreen
  // static Route route() {
  //   return MaterialPageRoute(
  //     settings: RouteSettings(name: routeName),
  //     builder: (context) => UsersScreen(),
  //   );
  // }

  const UsersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          print('Status: ${state.status}');
          if (state.status == UsersStateStatus.error) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state.status == UsersStateStatus.loaded) {
            final List<User> usersList = state.usersList;

            return CustomScrollView(
              slivers: [
                FlexibleAppBar(title: 'Users'),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 0.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final user = usersList[index];
                        return UserRow(
                          title: user.displayName,
                          subtitle: user.bio.isEmpty ? user.email : user.bio,
                          imageUrl: user.profileImageUrl,
                          onChat: () {
                            Navigator.of(context).pushNamed(
                              ChattingScreen.routeName,
                              arguments: ChattingScreenArgs(user: user),
                            );
                          },
                          onView: () {
                            Navigator.of(context).pushNamed(
                              ViewProfileScreen.routeName,
                              arguments: ViewProfileScreenArgs(user: user),
                            );
                          },
                        );
                      },
                      childCount: usersList.length,
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
