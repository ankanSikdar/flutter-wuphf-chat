import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        if (state.status == UsersStateStatus.error) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state.status == UsersStateStatus.loaded) {
          final List<User> usersList = state.usersList;

          return ListView.builder(
            itemCount: usersList.length,
            itemBuilder: (context, index) {
              final user = usersList[index];
              return Container(
                height: 100,
                width: 200,
                child: Text(user.displayName),
              );
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
