import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker/bloc/auth/authentication_cubit.dart';
import 'package:health_tracker/bloc/connectivity/connectivity_cubit.dart';
import 'package:health_tracker/bloc/onboarding/onboarding_cubit.dart';
import 'package:health_tracker/ui/screens/auth/onboarding_screen.dart';
import 'package:health_tracker/ui/screens/auth/welcome_screen.dart';
import 'package:health_tracker/ui/widgets/indicator_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/ui/screens/auth/login_screen.dart';
import 'package:health_tracker/shared/services/authentication_service.dart';
import 'package:health_tracker/shared/styles/themes.dart';
import 'package:health_tracker/ui/widgets/navigation_widget.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await UserPreferences.init();
  final prefs = await SharedPreferences.getInstance();
  final bool? seen = prefs.getBool('seen');

  runApp(MyApp(seen: seen));
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
              // ChangeNotifierProvider(
              //   create: (_) => UserProvider(),
              // ),
              // Provider<AuthenticationService>(
              //   create: (_) => AuthenticationService(FirebaseAuth.instance, FirebaseFirestore.instance),
              // ),
              // StreamProvider(
              //     create: (context) =>
              //         context.read<AuthenticationService>().authStateChanges,
              //     initialData: null),
              ChangeNotifierProvider(create: ((context) => ThemeNotifier()))
            ],
            child: Consumer<ThemeNotifier>(
              builder: (context, value, child) {
                return MaterialApp(
                  title: title,
                  debugShowCheckedModeBanner: false,
                  theme: value.darkTheme
                      ? MyThemes.darkTheme
                      : MyThemes.lightTheme,
                  home: /*const AuthenticationWrapper(),*/
                      StreamBuilder<User?>(
                          stream: FirebaseAuth.instance.authStateChanges(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const MyCircularIndicator();
                            }
                            if (snapshot.hasData) {
                              return const Navigation();
                            }
                            if (seen == null) {
                              return const WelcomeScreen();
                            }
                            return const OnBoardingScreen();
                            // if (snapshot.connectionState ==
                            //     ConnectionState.active) {
                            //   if (snapshot.hasData) {
                            //     return const AuthWrapper();
                            //   } else if (snapshot.hasError) {
                            //     return Center(
                            //       child: Text('${snapshot.error}'),
                            //     );
                            //   }
                            // }
                            // if (snapshot.connectionState ==
                            //     ConnectionState.waiting) {
                            //   return const Center(
                            //     child: CircularProgressIndicator(),
                            //   );
                            // }

                            // return const WelcomeScreen();
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
// ? 2 
// class AuthWrapper extends StatefulWidget {
//   const AuthWrapper({Key? key}) : super(key: key);

//   @override
//   State<AuthWrapper> createState() => _AuthWrapperState();
// }

// class _AuthWrapperState extends State<AuthWrapper> {
//   @override
//   void initState() {
//     super.initState();
//     addData();
//   }

//   addData() async {
//     UserProvider _userProvider =
//         Provider.of<UserProvider>(context, listen: false);
//     await _userProvider.refreshUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Navigation();
//   }
// }

// ? 1
// class AuthenticationWrapper extends StatelessWidget {
//   const AuthenticationWrapper({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final firebaseUser = context.watch<User?>();

//     if (firebaseUser != null) {
//       return const Navigation();
//     }
//     return const WelcomeScreen();
//   }
// }
