import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:health_tracker/screens/auth/welcome_screen.dart';
import 'package:sizer/sizer.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/screens/auth/login_screen.dart';
import 'package:health_tracker/shared/services/authentication_service.dart';
import 'package:health_tracker/shared/themes.dart';
import 'package:health_tracker/utils/user_preferences.dart';
import 'package:health_tracker/widgets/navigation_widget.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await UserPreferences.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Health Tracker';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            Provider<AuthenticationService>(
              create: (_) => AuthenticationService(FirebaseAuth.instance),
            ),
            StreamProvider(
                create: (context) =>
                    context.read<AuthenticationService>().authStateChanges,
                initialData: null),
            ChangeNotifierProvider(create: ((context) => ThemeNotifier()))
          ],
          child: Consumer<ThemeNotifier>(
            builder: (context, value, child) {
              return MaterialApp(
                title: title,
                debugShowCheckedModeBanner: false,
                theme:
                    value.darkTheme ? MyThemes.darkTheme : MyThemes.lightTheme,
                home: const AuthenticationWrapper(),
              );
            },
          ),
        );
      },
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const Navigation();
    }
    return const WelcomeScreen();
  }
}
