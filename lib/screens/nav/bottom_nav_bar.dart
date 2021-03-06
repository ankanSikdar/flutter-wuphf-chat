import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:wuphf_chat/config/configs.dart';
import 'package:wuphf_chat/repositories/repositories.dart';
import 'package:wuphf_chat/screens/chats/bloc/chats_bloc.dart';
import 'package:wuphf_chat/screens/groups/bloc/groups_bloc.dart';
import 'package:wuphf_chat/screens/screens.dart';
import 'package:wuphf_chat/screens/users/bloc/users_bloc.dart';

class BottomNavBarScreen extends StatefulWidget {
  static const String routeName = '/nav-screen';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => BottomNavBarScreen(),
    );
  }

  BottomNavBarScreen({Key key}) : super(key: key);

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _screens = [
    BlocProvider<UsersBloc>(
      create: (context) => UsersBloc(
        authBloc: context.read<AuthBloc>(),
        userRepository: context.read<UserRepository>(),
      )..add(UsersFetchUser()),
      child: UsersScreen(),
    ),
    BlocProvider<ChatsBloc>(
      create: (context) => ChatsBloc(
        messagesRepository: context.read<MessagesRepository>(),
      ),
      child: ChatsScreen(),
    ),
    BlocProvider<GroupsBloc>(
      create: (context) => GroupsBloc(
        groupsRepository: context.read<GroupsRepository>(),
      ),
      child: GroupsScreen(),
    ),
    BlocProvider<LiveUserBloc>(
      create: (context) => LiveUserBloc(
        userRepository: context.read<UserRepository>(),
        userId: context.read<AuthBloc>().state.user.uid,
      ),
      child: UserProfileScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _screens.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(ThemeConfig.borderRadius),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -2),
                blurRadius: 4.0,
                color: Theme.of(context).accentColor.withOpacity(0.2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(ThemeConfig.borderRadius),
            ),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.users), label: 'Contacts'),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.solidComment),
                    label: 'Chats'),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.solidComments),
                    label: 'Groups'),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.solidUserCircle),
                    label: 'Profile'),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
