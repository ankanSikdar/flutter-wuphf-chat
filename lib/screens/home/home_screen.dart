import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/bloc/blocs.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home-screen";

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => HomeScreen(),
    );
  }

  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(context.read<AuthBloc>().state.user.displayName),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  context.read<AuthBloc>().add(AuthUserLogOut());
                })
          ],
        )
      ],
    );
  }
}
