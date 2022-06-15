import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker/bloc/auth/authentication_cubit.dart';
import 'package:health_tracker/bloc/connectivity/connectivity_cubit.dart';
import 'package:health_tracker/data/repositories/firebase_auth.dart';
import 'package:health_tracker/ui/screens/auth/registration_screen.dart';
import 'package:health_tracker/shared/styles/themes.dart';
import 'package:health_tracker/ui/widgets/button_widget.dart';
import 'package:health_tracker/ui/widgets/indicator_widget.dart';
import 'package:health_tracker/ui/widgets/navigation_widget.dart';
import 'package:health_tracker/ui/widgets/snackbar_widget.dart';
import 'package:health_tracker/ui/widgets/textfield_widget.dart';
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
    AuthenticationCubit authenticationCubit = BlocProvider.of(context);
    ConnectivityCubit connectivityCubit = BlocProvider.of(context);

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
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationErrorState) {
            MySnackBar.error(
                message: state.error.toString(),
                color: Colors.red,
                context: context);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Form(
                  key: _formKey,
                  child: BounceInDown(
                    duration: const Duration(milliseconds: 1500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   height: 8.h,
                        // ),
                        Text('Welcome back!',
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                ?.copyWith(
                                    fontSize: 20.sp,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          'Sign In To Continue !',
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    fontSize: 12.sp,
                                    letterSpacing: 2,
                                    // fontWeight: FontWeight.bold
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
                              if (connectivityCubit.state
                                  is ConnectivityOnlineState) {
                                await _authenticateWithEmailAndPass(
                                    context, authenticationCubit);
                                if (state is AuthenticationSuccessState) {
                                  if (!mounted) {
                                    return;
                                  }
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Navigation()));
                                }
                              } else {
                                MySnackBar.error(
                                    message:
                                        'Please Check Your Internet Connection',
                                    color: Colors.red,
                                    context: context);
                              }
                            }),
                        // Container(
                        //     // width: 80.h,
                        //     // padding: EdgeInsets.symmetric(vertical: 0.1.h),
                        //     child: _buildLoginButton(MyThemes.primary, 80.w)),
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
                                  .subtitle1
                                  ?.copyWith(
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.bold),
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
                                    .headline1
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
                                  .headline1
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
                              onTap: () {
                                if (connectivityCubit.state
                                    is ConnectivityOnlineState) {
                                  authenticationCubit.googleSignIn();
                                } else {
                                  MySnackBar.error(
                                      message:
                                          'Please Check Your Internet Connection',
                                      color: Colors.red,
                                      context: context);
                                }
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
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    'It will be added soon !!',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
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
          );
        },
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

  Future<void> _authenticateWithEmailAndPass(context, AuthenticationCubit cubit) async {
    if (_formKey.currentState!.validate()) {
      cubit.login(
          email: _emailController.text, password: _passwordController.text);
      // FirebaseAuthRepo().login(email: _emailController.text, password: _passwordController.text);
    }
  }
}
