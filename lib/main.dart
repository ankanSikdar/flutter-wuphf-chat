import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'config/configs.dart';
import 'screens/screens.dart';

Future<void> main() async {
  /*
   The WidgetFlutterBinding is used to interact with the Flutter engine. Firebase.initializeApp() needs to call native code to initialize Firebase, and since the plugin needs to use platform channels to call the native code, which is done asynchronously therefore you have to call ensureInitialized() to make sure that you have an instance of the WidgetsBinding.
  */
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wuphf Chat',
      theme: ThemeConfig.themeData,
      initialRoute: SignUpScreen.routeName,
      onGenerateRoute: CustomRouter.onGenerateRoute,
    );
  }
}
