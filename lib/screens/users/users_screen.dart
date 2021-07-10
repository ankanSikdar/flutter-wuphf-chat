import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';

import 'package:wuphf_chat/models/models.dart';
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
    return BlocBuilder<UsersBloc, UsersState>(
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
              SliverAppBar(
                title: Text(
                  'Users',
                  style: Theme.of(context).textTheme.headline3,
                ),
                automaticallyImplyLeading: false,
                toolbarHeight: 200,
                backgroundColor: Colors.white,
              ),
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
    );
  }
}