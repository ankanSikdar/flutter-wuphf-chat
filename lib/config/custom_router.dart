import 'package:flutter/material.dart';
import 'package:wuphf_chat/screens/screens.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: RouteSettings(name: '/'),
          builder: (context) => Scaffold(),
        );
      case HomeScreen.routeName:
        return HomeScreen.route();
      case SignUpScreen.routeName:
        return SignUpScreen.route();
      default:
        return _errorRoute();
    }
  }

  // TODO Design error screen
  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('ERROR'),
        ),
        body: Center(
          child: Text('Something went wrong!'),
        ),
      ),
    );
  }
}
