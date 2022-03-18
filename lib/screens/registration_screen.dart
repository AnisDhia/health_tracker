import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_tracker/services/authentication_service.dart';
import 'package:health_tracker/widgets/button-widget.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
 
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
 
class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Health Tracker',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              
              Container(
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(0,15,0,15),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: buildSignupButton(), 
              ),

              // const SizedBox(height: 5,),

              Row(
                children: <Widget>[
                  const Text('Already have an account?'),
                  TextButton(
                    child: const Text(
                      'Log in',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      //signup screen
                      Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),

              ElevatedButton.icon(
                icon: const FaIcon(FontAwesomeIcons.google),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                ),
                label: const Text('Sign Up with Google'),
                onPressed: () {
                  // final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                  // provider.googleLogin();
                  context.read<AuthenticationService>().signInWithGoogle();
                },
              ),
            ],
          )),
    );
  }


  Widget buildSignupButton() => ButtonWidget(
  text: 'Sign Up',
  onClicked: () {
    context.read<AuthenticationService>().signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
      );
  },
);
}