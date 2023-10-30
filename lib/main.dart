// with getting words from 3 to 13 logic

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'HomePage.dart';
import 'firebase_queries/read_words.dart';
// import 'firebase_queries/words.dart';

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

  // Check if a user is already signed in
  final User? user = FirebaseAuth.instance.currentUser;


// disable network because i reached my daily quota
  await FirebaseFirestore.instance.disableNetwork();


  if (user == null) {
    // If no user is signed in, perform anonymous sign-in
    await signInAnonymously();
  } else {
    print('User is already signed in: ${user.uid}');
  }

  // // Disable Firestore caching for testing purposes
  FirebaseFirestore.instance.settings = const Settings(
    // cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    persistenceEnabled: true,
  );

  // // Fetch the words using fetchWordsFromFirebase
  FirestoreService firestoreService = FirestoreService();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> words =
      await firestoreService.getRandomWords();

  runApp(MyApp(words: words)); // Pass the fetched words to MyApp
}

// anonymous sign in function
Future<void> signInAnonymously() async {
  try {
    // signed in anonymously but in web browser, exiting creates new anonymous user
    await FirebaseAuth.instance.signInAnonymously();
    print('Signed in anonymously');
  } catch (e) {
    print('Error signing in anonymously: $e');
  }
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
