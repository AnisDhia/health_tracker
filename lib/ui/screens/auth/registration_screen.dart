import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/ui/screens/auth/login_screen.dart';
import 'package:health_tracker/shared/constants/consts_variables.dart';
import 'package:health_tracker/shared/services/authentication_service.dart';
import 'package:health_tracker/shared/styles/themes.dart';
import 'package:health_tracker/shared/utilities/utils.dart';
import 'package:health_tracker/ui/widgets/button_widget.dart';
import 'package:health_tracker/ui/widgets/navigation_widget.dart';
import 'package:health_tracker/ui/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';
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
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const Navigation();
    }
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
                    // SizedBox(
                    //   height: 8.h,
                    // ),
                    Text('Hey !',
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                            fontSize: 20.sp,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Text(
                      'Create a New Account !',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
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
                      func: () async {
                        String? res = await AuthenticationService().signUp(
                            name: _nameController.text.trim(),
                            sex: _sex,
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim());
                        if (res == 'success') {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Navigation()));
                        } else {
                          showSnackBar(context, res!);
                        }
                      },
                    ),
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
                                    builder: (context) => const LoginScreen()));
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
        // Padding(
        //     padding: const EdgeInsets.all(10),
        //     child: ListView(
        //       children: <Widget>[
        //         Container(
        //             alignment: Alignment.center,
        //             padding: const EdgeInsets.all(10),
        //             child: const Text(
        //               'Health Tracker',
        //               style: TextStyle(
        //                   color: Colors.red,
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 30),
        //             )),
        //         Container(
        //             alignment: Alignment.center,
        //             padding: const EdgeInsets.all(10),
        //             child: const Text(
        //               'Sign in',
        //               style: TextStyle(fontSize: 20),
        //             )),
        //         Container(
        //           padding: const EdgeInsets.all(10),
        //           child: TextField(
        //             controller: _emailController,
        //             decoration: const InputDecoration(
        //               border: OutlineInputBorder(),
        //               labelText: 'Email',
        //             ),
        //           ),
        //         ),
        //         Container(
        //           padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        //           child: TextField(
        //             obscureText: true,
        //             controller: _passwordController,
        //             decoration: const InputDecoration(
        //               border: OutlineInputBorder(),
        //               labelText: 'Password',
        //             ),
        //           ),
        //         ),
        //         TextButton(
        //           onPressed: () {
        //             //forgot password screen
        //           },
        //           child: const Text('Forgot Password',),
        //         ),
        //         Container(
        //             height: 50,
        //             padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        //             child: _buildLoginButton(),
        //             // ElevatedButton(
        //             //   child: const Text('Login'),
        //             //   onPressed: () {
        //             //     context.read<AuthenticationService>().signIn(
        //             //       email: _emailController.text.trim(),
        //             //       password: _passwordController.text.trim()
        //             //     );
        //             //   },
        //             // )
        //         ),
        //         Row(
        //           children: <Widget>[
        //             const Text('Don\'t have an account?'),
        //             TextButton(
        //               child: const Text(
        //                 'Sign up!',
        //                 style: TextStyle(fontSize: 20),
        //               ),
        //               onPressed: () {
        //                 //signup screen
        //                 Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
        //               },
        //             )
        //           ],
        //           mainAxisAlignment: MainAxisAlignment.center,
        //         ),
        //         Container(
        //           height: 50,
        //           padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        //           child: ElevatedButton.icon(
        //             icon: const FaIcon(FontAwesomeIcons.google),
        //             style: ElevatedButton.styleFrom(
        //               shape: const StadiumBorder(),
        //               primary: Colors.white,
        //               onPrimary: Colors.black,
        //               // minimumSize: const Size(double.infinity, 50),
        //               padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        //             ),
        //             label: const Text('Sign In with Google'),
        //             onPressed: () {
        //               // final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
        //               // provider.googleLogin();
        //               context.read<AuthenticationService>().signInWithGoogle();
        //             },
        //           ),
        //         ),
        //       ],
        //     )),
      ),
    );
  }
}
