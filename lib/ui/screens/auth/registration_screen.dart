import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker/bloc/auth/authentication_cubit.dart';
import 'package:health_tracker/bloc/connectivity/connectivity_cubit.dart';
import 'package:health_tracker/ui/screens/auth/login_screen.dart';
import 'package:health_tracker/shared/constants/consts_variables.dart';
import 'package:health_tracker/shared/styles/themes.dart';
import 'package:health_tracker/ui/widgets/button_widget.dart';
import 'package:health_tracker/ui/widgets/indicator_widget.dart';
import 'package:health_tracker/ui/widgets/navigation_widget.dart';
import 'package:health_tracker/ui/widgets/snackbar_widget.dart';
import 'package:health_tracker/ui/widgets/textfield_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:animate_do/animate_do.dart';
import 'package:health_tracker/shared/utilities/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  Sex? _sex = Sex.male;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
            // Showing the error message if the user has entered invalid credentials
            MySnackBar.error(
                message: state.error.toString(),
                color: Colors.red,
                context: context);
          }

          if (state is AuthenticationSuccessState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Navigation()));
          }
        },
        builder: (context, state) {
          if (state is AuthenticationLoadingState) {
            return const MyCircularIndicator();
          }
          if (state is! AuthenticationSuccessState) {
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
                          Text('Hey !',
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
                            'Create a New Account !',
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
                            hint: 'Username',
                            icon: Icons.person,
                            keyboardtype: TextInputType.emailAddress,
                            validator: (value) {
                              return value!.length < 3 ? 'Unvalid Name' : null;
                            },
                            textEditingController: _nameController,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              Radio<Sex>(
                                value: Sex.male,
                                groupValue: _sex,
                                onChanged: (Sex? value) {
                                  setState(() {
                                    _sex = value;
                                  });
                                },
                                activeColor: Colors.red,
                              ),
                              const Text("Male"),
                              Radio<Sex>(
                                value: Sex.female,
                                groupValue: _sex,
                                onChanged: (Sex? value) {
                                  setState(() {
                                    _sex = value;
                                  });
                                },
                                activeColor: Colors.red,
                              ),
                              const Text("Female"),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
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
                              title: 'CREATE ACCOUNT',
                              func: () {
                                if (connectivityCubit.state
                                    is ConnectivityOnlineState) {
                                  _signUpWithEmailAndPass(
                                      context, authenticationCubit);
                                } else {
                                  MySnackBar.error(
                                      message:
                                          'Please Check Your Interenet Connection',
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
                                'Already have an Account ?',
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
                                              const LoginScreen()));
                                },
                                child: Text(
                                  'Login',
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _signUpWithEmailAndPass(context, AuthenticationCubit cubit) {
    if (_formKey.currentState!.validate()) {
      cubit.register(
          fullname: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text);
    }
  }
}
