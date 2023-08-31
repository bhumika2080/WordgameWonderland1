// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/services.dart';
// import 'firebase_options.dart';
// import 'HomePage.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is initialized

//   // Lock the orientation to portrait mode on mobile devices
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(const MyApp()); // Run your Flutter app
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark(),
//       home: const HomePageWidget(),
//     );
//   }
// }

// with getting words from 3 to 13 logic

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'HomePage.dart';
import 'firebase_queries/read_words.dart'; // Import the read_words.dart file

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   // Fetch the words using FirestoreService
//   FirestoreService firestoreService = FirestoreService();
//   List<QueryDocumentSnapshot<Map<String, dynamic>>> words = await firestoreService.getWords();

//   runApp(MyApp(words: words)); // Pass the fetched words to MyApp
// }

// class MyApp extends StatelessWidget {
//   final List<QueryDocumentSnapshot<Map<String, dynamic>>> words;

//   const MyApp({Key? key, required this.words}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark(),
//       home: HomePageWidget(words: words), // Pass the fetched words to HomePageWidget
//     );
//   }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Firebase before fetching data from Firestore
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // // Disable Firestore caching for testing purposes
  // FirebaseFirestore.instance.settings = const Settings(
  //   cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  //   persistenceEnabled: false,
  // );

  // Fetch the words using FirestoreService
  FirestoreService firestoreService = FirestoreService();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> words =
      await firestoreService.getRandomWords();

  runApp(MyApp(words: words)); // Pass the fetched words to MyApp
}

class MyApp extends StatelessWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> words;

  const MyApp({Key? key, required this.words}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePageWidget(
          words: words), // Pass the fetched words to HomePageWidget
    );
  }
}
