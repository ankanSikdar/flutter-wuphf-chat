import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wuphf_chat/screens/home/home_screen.dart';

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
    Container(
      child: Center(
        child: Text('Users'),
      ),
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
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.users), label: 'Contacts'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.comments), label: 'Chat'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.userCircle), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).accentColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
