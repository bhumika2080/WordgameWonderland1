// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase_ui;
// import 'package:flutter/material.dart';
// import 'package:flutterfire_ui/auth.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({Key? key}) : super(key: key);

//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           // if (snapshot.hasData) {
//             return const SignInScreen(
//               providerConfigs: [
//                 EmailProviderConfiguration(),
//                 GoogleProviderConfiguration(clientId: 'google_client_id_test'),
//               ],

//               //from firebase_ui_auth
//               // providers: [
//               //   firebase_ui.EmailAuthProvider(),
//               //   firebase_ui.AuthProvider(),
//               //   firebase_ui.GoogleAuthProvider(),
//               // ],
//             );
//           // }
//           // return Container();
//         });
//   }
// }

// // class GoogleAuthProvider {}
