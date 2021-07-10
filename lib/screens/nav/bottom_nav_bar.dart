import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:wuphf_chat/repositories/repositories.dart';
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
    HomeScreen(),
    Container(
      child: Center(
        child: Text('Profile'),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _screens.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.users), label: 'Contacts'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.comments), label: 'Chat'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.userCircle), label: 'Profile'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
