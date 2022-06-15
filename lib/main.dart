// import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker/bloc/auth/authentication_cubit.dart';
import 'package:health_tracker/bloc/connectivity/connectivity_cubit.dart';
import 'package:health_tracker/bloc/onboarding/onboarding_cubit.dart';
import 'package:health_tracker/shared/services/user_provider.dart';
import 'package:health_tracker/ui/screens/auth/onboarding_screen.dart';
import 'package:health_tracker/ui/screens/auth/welcome_screen.dart';
import 'package:health_tracker/ui/widgets/indicator_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/shared/styles/themes.dart';
import 'package:health_tracker/ui/widgets/navigation_widget.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light));
  // await UserPreferences.init();
  final prefs = await SharedPreferences.getInstance();
  final bool? seen = prefs.getBool('seen');

  runApp(const MyApp(seen: false));
}

class MyApp extends StatelessWidget {
  static const String title = 'Health Tracker';

  const MyApp({Key? key, required this.seen}) : super(key: key);

  final bool? seen;

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (context) =>
                  ConnectivityCubit()..initializeConnectivity(),
            ),
            BlocProvider(create: (context) => OnboardingCubit()),
            BlocProvider(create: (context) => AuthenticationCubit()),
          ],
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: ((context) => ThemeNotifier())),
              ChangeNotifierProvider(create: ((_) => UserProvider()))
            ],
            child: Consumer<ThemeNotifier>(
              builder: (context, value, child) {
                return MaterialApp(
                  title: title,
                  debugShowCheckedModeBanner: false,
                  theme: value.darkTheme
                      ? MyThemes.darkTheme
                      : MyThemes.lightTheme,
                  home: StreamBuilder<User?>(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const MyCircularIndicator();
                        }
                        if (snapshot.hasData) {
                          return const Navigation();
                        }
                        if (seen == null) {
                          return const WelcomeScreen();
                        }
                        return const OnBoardingScreen();
                      }),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
