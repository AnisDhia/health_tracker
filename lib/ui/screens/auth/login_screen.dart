import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/data/repositories/firebase_auth.dart';
import 'package:health_tracker/ui/screens/auth/registration_screen.dart';
import 'package:health_tracker/shared/styles/themes.dart';
import 'package:health_tracker/ui/widgets/button_widget.dart';
import 'package:health_tracker/ui/widgets/snackbar_widget.dart';
import 'package:health_tracker/ui/widgets/textfield_widget.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sizer/sizer.dart';
import 'package:animate_do/animate_do.dart';
import 'package:health_tracker/shared/utilities/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: Form(
              key: _formKey,
              child: BounceInDown(
                duration: const Duration(milliseconds: 1500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome back!',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 20.sp,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Text(
                      'Sign In To Continue !',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 12.sp,
                            letterSpacing: 2,
                          ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    MyTextfield(
                      hint: 'Email Address',
                      icon: Icons.email,
                      keyboardtype: TextInputType.emailAddress,
                      validator: (value) {
                        return !Validators.isValidEmail(value!)
                            ? 'Enter a valid email'
                            : null;
                      },
                      textEditingController: _emailController,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    MyTextfield(
                      hint: 'Password',
                      icon: Icons.password,
                      keyboardtype: TextInputType.text,
                      obscure: true,
                      validator: (value) {
                        return value!.length < 6
                            ? "Enter min. 6 characters"
                            : null;
                      },
                      textEditingController: _passwordController,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    ButtonWidget(
                        color: MyThemes.primary,
                        width: 80.w,
                        title: 'Login',
                        func: () async {
                          bool isConnected =
                              await InternetConnectionChecker().hasConnection;
                          if (isConnected) {
                            if (!mounted) {
                              return;
                            }
                            _authenticateWithEmailAndPass(context);
                          } else {
                            MySnackBar.error(
                                message:
                                    'Please Check Your Internet Connection',
                                color: Colors.red,
                                context: context);
                          }
                        }),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an Account ?',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontSize: 8.sp, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          child: Text(
                            'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                    fontSize: 9.sp,
                                    color: MyThemes.primary,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _myDivider(),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Or',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                  fontSize: 9.sp,
                                  color: MyThemes.primary,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        _myDivider(),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            // bool isConnected = await InternetConnectionChecker().hasConnection;
                            // if (isConnected) {
                            //   FirebaseAuthRepo().googleSignIn();
                            // } else {
                            //   MySnackBar.error(
                            //       message:
                            //           'Please Check Your Internet Connection',
                            //       color: Colors.red,
                            //       context: context);
                            // }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'It will be added soon !!',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                        fontSize: 11.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: MyThemes.primary,
                            ));
                          },
                          child: Image.asset(
                            'assets/icons/google.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'It will be added soon !!',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                        fontSize: 11.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: MyThemes.primary,
                            ));
                          },
                          child: Image.asset(
                            'assets/icons/facebook.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _myDivider() {
    return Container(
      width: 27.w,
      height: 0.2.h,
      color: Theme.of(context).dividerColor,
    );
  }

  void _authenticateWithEmailAndPass(context) async {
    if (_formKey.currentState!.validate()) {
      await FirebaseAuthRepo()
          .login(
              email: _emailController.text, password: _passwordController.text)
          .onError((error, stackTrace) {
        MySnackBar.error(
            message: error.toString(), color: Colors.red, context: context);
      });
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pop(context);
      }
    }
  }
}
