import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:health_tracker/shared/services/user_provider.dart';
import 'package:health_tracker/ui/screens/auth/welcome_screen.dart';
import 'package:health_tracker/ui/widgets/indicator_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/shared/styles/themes.dart';
import 'package:health_tracker/ui/widgets/navigation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid =
      const AndroidInitializationSettings('splash');
  // var initializationSettingsIOS = IOSInitializationSettings(
  //     requestAlertPermission: true,
  //     requestBadgePermission: true,
  //     requestSoundPermission: true,
  //     onDidReceiveLocalNotification:
  //         (int id, String? title, String? body, String? payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
    debugPrint('notification payload: $payload');
  });

  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light));
  // await UserPreferences.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Health Tracker';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: ((context) => ThemeNotifier())),
            ChangeNotifierProvider(create: ((_) => UserProvider()))
          ],
          child: Consumer<ThemeNotifier>(
            builder: (context, value, child) {
              return MaterialApp(
                title: title,
                debugShowCheckedModeBanner: false,
                theme:
                    value.darkTheme ? MyThemes.darkTheme : MyThemes.lightTheme,
                home: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const MyCircularIndicator();
                      }
                      if (snapshot.hasData) {
                        return const Navigation();
                      }
                      return const WelcomeScreen();
                    }),
              );
            },
          ),
        );
      },
    );
  }
}
