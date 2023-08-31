import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> fetchWordsFromFirebase() async {
  List<String> words = [];

  // Fetch the words from Firebase
  QuerySnapshot<Object?> snapshot = await FirebaseFirestore.instance
      .collection('WordsListRowy')
      .get();

  // Extract the 'lemma' field from each document and add it to the list
  for (var wordDoc in snapshot.docs) {
    String word = wordDoc['lemma'].toString().toUpperCase();
    words.add(word);
  }

  return words;
}
