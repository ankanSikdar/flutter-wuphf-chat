import 'package:flutter/material.dart';
import 'package:wuphf_chat/screens/create_group/create_group_screen.dart';
import 'package:wuphf_chat/screens/screens.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    //* Preparing For Release
    // print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: RouteSettings(name: '/'),
          builder: (context) => Scaffold(),
        );
      case BottomNavBarScreen.routeName:
        return BottomNavBarScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case ChatsScreen.routeName:
        return ChatsScreen.route();
      case SignUpScreen.routeName:
        return SignUpScreen.route();
      case ForgotPasswordScreen.routeName:
        return ForgotPasswordScreen.route();
      case CreateGroupScreen.routeName:
        return CreateGroupScreen.route(args: settings.arguments);
      case EditProfileScreen.routeName:
        return EditProfileScreen.route(args: settings.arguments);
      case ChattingScreen.routeName:
        return ChattingScreen.route(args: settings.arguments);
      case ViewProfileScreen.routeName:
        return ViewProfileScreen.route(args: settings.arguments);
      case ViewImageScreen.routeName:
        return ViewImageScreen.route(args: settings.arguments);
      case GroupChattingScreen.routeName:
        return GroupChattingScreen.route(args: settings.arguments);
      case ViewGroupScreen.routeName:
        return ViewGroupScreen.route(args: settings.arguments);
      case EditGroupScreen.routeName:
        return EditGroupScreen.route(args: settings.arguments);
      case DevDetailsScreen.routeName:
        return DevDetailsScreen.route();
      case AppDetailsScreen.routeName:
        return AppDetailsScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: Text('Something went wrong!'),
        ),
      ),
    );
  }
}
