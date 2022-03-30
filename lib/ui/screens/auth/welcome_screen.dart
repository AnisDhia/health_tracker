import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/ui/screens/auth/login_screen.dart';
import 'package:health_tracker/ui/screens/auth/registration_screen.dart';
import 'package:health_tracker/shared/styles/themes.dart';
import 'package:health_tracker/ui/widgets/button_widget.dart';
import 'package:sizer/sizer.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BounceInDown(
                duration: const Duration(milliseconds: 1500),
                child: Image.asset(
                  'assets/images/Login.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                'Hello !',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(
                      fontSize: 20.sp,
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                'Welcome to Health Tracker\n Get started !',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      letterSpacing: 3,
                      fontSize: 10.sp,
                      wordSpacing: 2,
                    ),
              ),
              SizedBox(
                height: 4.h,
              ),
              ButtonWidget(
                color: MyThemes.primary,
                width: 80.w,
                title: 'LOGIN',
                func: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              ButtonWidget(
                color: MyThemes.primary,
                width: 80.w,
                title: 'CREATE ACCOUNT',
                func: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                },
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}