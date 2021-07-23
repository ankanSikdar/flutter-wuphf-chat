import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/screens/screens.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => SplashScreen(),
    );
  }

  const SplashScreen({Key key}) : super(key: key);

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
            return Navigator.of(context)
                .pushNamed(BottomNavBarScreen.routeName);
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
