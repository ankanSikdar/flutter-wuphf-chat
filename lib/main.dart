import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:wuphf_chat/repositories/repositories.dart';
import 'config/configs.dart';
import 'screens/screens.dart';

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'new_chat_group_notifications', // id
  'New Chat and New Group', // title
  'This channel is used to inform you about New Chats and New Groups.', // description
  importance: Importance.high,
);

Future<void> main() async {
  // Google Fonts License
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  /*
   The WidgetFlutterBinding is used to interact with the Flutter engine. Firebase.initializeApp() needs to call native code to initialize Firebase, and since the plugin needs to use platform channels to call the native code, which is done asynchronously therefore you have to call ensureInitialized() to make sure that you have an instance of the WidgetsBinding.
  */
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));

  //* Preparing For Release
  // Bloc.observer = AppBlocObserver();

  await Firebase.initializeApp();

// Initializing Notifications Settings
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // OnMessage Listener
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              icon: android?.smallIcon,
            ),
          ));
    }
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Firebase Analytics Setup
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepository(),
        ),
        RepositoryProvider<MessagesRepository>(
          create: (_) => MessagesRepository(),
        ),
        RepositoryProvider<StorageRepository>(
          create: (_) => StorageRepository(),
        ),
        RepositoryProvider<PresenceRepository>(
          create: (_) => PresenceRepository(),
        ),
        RepositoryProvider<GroupsRepository>(
          create: (_) => GroupsRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
              userRepository: context.read<UserRepository>(),
              presenceRepository: context.read<PresenceRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Wuphf Chat',
          theme: ThemeConfig.themeData,
          initialRoute: SplashScreen.routeName,
          onGenerateRoute: CustomRouter.onGenerateRoute,
          navigatorObservers: [observer],
        ),
      ),
    );
  }
}
