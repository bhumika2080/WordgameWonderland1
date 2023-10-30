// import 'package:cloud_firestore/cloud_firestore.dart';

// // Future<List<String>> fetchWordsFromFirebase() async {
// //   List<String> words = [];

// Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchWordsFromFirebase() async {
//   List<QueryDocumentSnapshot<Map<String, dynamic>>> words = [];

//   // Fetch the words from Firebase
//   QuerySnapshot<Object?> snapshot = await FirebaseFirestore.instance
//       .collection('WordsListRowy')
//       .get();

//   // Extract the 'lemma' field from each document and add it to the list
//   for (var wordDoc in snapshot.docs) {
//     String word = wordDoc['lemma'].toString().toUpperCase();
//     words.add(word as QueryDocumentSnapshot<Map<String, dynamic>>);
//   }

//   return words;
// }


// //failed attempt at replacing read_words.dart
// import 'package:cloud_firestore/cloud_firestore.dart';

// Future<List<WordData>> fetchWordsFromFirebase() async {
//   List<WordData> words = [];

//   // Fetch the words from Firebase
//   QuerySnapshot<Object?> snapshot =
//       await FirebaseFirestore.instance.collection('WordsListRowy').get();

//   // Extract the 'lemma' field from each document and add it to the list
//   for (var wordDoc in snapshot.docs) {
//     String word = wordDoc['lemma'].toString().toUpperCase();
//     words.add(
//         WordData(wordDoc as QueryDocumentSnapshot<Map<String, dynamic>>, word));
//   }

//   return words;
// }

// class WordData {
//   final QueryDocumentSnapshot<Map<String, dynamic>> snapshot;
//   final String word;

//   WordData(this.snapshot, this.word);
// }





import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> fetchWordsFromFirebase() async {
  List<String> words = [];

  // Fetch the words from Firebase
  QuerySnapshot<Object?> snapshot = await FirebaseFirestore.instance
      .collection('WordsListRowy')
      // use .get() if you want to fetch directly from the firestore
      .get(const GetOptions(source: Source.cache));

  // Extract the 'lemma' field from each document and add it to the list
  for (var wordDoc in snapshot.docs) {
    String word = wordDoc['lemma'].toString().toUpperCase();
    words.add(word);
  }

  return words;
}
