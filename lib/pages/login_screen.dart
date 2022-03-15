// import 'package:flutter/material.dart';
// import 'package:health_tracker/services/authentication_service.dart';
// import 'package:provider/provider.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
 
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
 
// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
 
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.all(10),
//         child: ListView(
//           children: <Widget>[
//             Container(
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.all(10),
//                 child: const Text(
//                   'Health Tracker',
//                   style: TextStyle(
//                       color: Colors.blue,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 30),
//                 )),
//             Container(
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.all(10),
//                 child: const Text(
//                   'Sign in',
//                   style: TextStyle(fontSize: 20),
//                 )),
//             Container(
//               padding: const EdgeInsets.all(10),
//               child: TextField(
//                 controller: emailController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Email',
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//               child: TextField(
//                 obscureText: true,
//                 controller: passwordController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Password',
//                 ),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 //forgot password screen
//               },
//               child: const Text('Forgot Password',),
//             ),
//             Container(
//                 height: 50,
//                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 child: ElevatedButton(
//                   child: const Text('Login'),
//                   onPressed: () {
//                     context.read<AuthenticationService>().signIn(
//                       email: emailController.text.trim(),
//                       password: passwordController.text.trim()
//                     );
//                   },
//                 )
//             ),
//             // Row(
//             //   children: <Widget>[
//             //     const Text('Does not have account?'),
//             //     TextButton(
//             //       child: const Text(
//             //         'Sign in',
//             //         style: TextStyle(fontSize: 20),
//             //       ),
//             //       onPressed: () {
//             //         //signup screen
//             //       },
//             //     )
//             //   ],
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             // ),
//           ],
//         ));
//   }
// }