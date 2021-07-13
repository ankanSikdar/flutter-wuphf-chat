import 'package:flutter/material.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileScreen extends StatelessWidget {
  static const String routeName = '/user-profile-screen';

  const UserProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(AuthUserLogOut());
            },
          ),
        ],
      ),
    );
  }
}
