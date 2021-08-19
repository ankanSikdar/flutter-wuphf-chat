import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/screens/screens.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => SplashScreen(),
    );
  }

  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  RemoteMessage initialMessage;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    setupInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final data = message.data;
      handleNotification(data: data);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        context.read<AuthBloc>().add(AppResumedUpdatePresence());
        break;
      case AppLifecycleState.inactive:
        // Do nothing
        break;
      case AppLifecycleState.paused:
        context.read<AuthBloc>().add(AppInBackgroundUpdatePresence());
        break;
      case AppLifecycleState.detached:
        // Already Handled
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> setupInitialMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  }

  void handleNotification({@required Map<String, dynamic> data}) {
    if (data['type'] == 'new-chat') {
      final userId = data['userId'];
      Navigator.of(context).pushNamed(ChattingScreen.routeName,
          arguments: ChattingScreenArgs(userId: userId));
    } else if (data['type'] == 'new-group') {
      final groupDbId = data['groupDbId'];
      Navigator.of(context).pushNamed(GroupChattingScreen.routeName,
          arguments: GroupChattingScreenArgs(groupId: groupDbId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          // No user is found
          if (state.status == AuthStatus.unauthenticated) {
            return Navigator.of(context).pushNamed(SignUpScreen.routeName);
          }

          // User is found and user is logged in
          if (state.status == AuthStatus.authenticated) {
            if (initialMessage == null) {
              // App opened normally
              return Navigator.of(context)
                  .pushNamed(BottomNavBarScreen.routeName);
            } else {
              // App opened from terminated state by clicking notification
              Navigator.of(context).pushNamed(BottomNavBarScreen.routeName);
              handleNotification(data: initialMessage.data);
              return null;
            }
          }
        },
        // When status is unknown
        //* Status changes to unauthenticated when no user is found or to authenticated when user is found
        child: Scaffold(
          body: Center(
            child: LoadingIndicator(),
          ),
        ),
      ),
    );
  }
}
