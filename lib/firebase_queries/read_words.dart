import 'package:cloud_firestore/cloud_firestore.dart';



// // without print on debug console


// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirestoreService {
//   final CollectionReference wordsCollection = FirebaseFirestore.instance.collection('WordsListRowy');

//   Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getWords() async {
//     List<QueryDocumentSnapshot<Map<String, dynamic>>> words = [];

//     for (int length = 3; length <= 13; length++) {
//       QuerySnapshot<Object?> snapshot = await wordsCollection
//           .where('length', isEqualTo: length)
//           .limit(8)
//           .get();

//       words.addAll(snapshot.docs as Iterable<QueryDocumentSnapshot<Map<String, dynamic>>>);

//       print('Fetched ${snapshot.docs.length} words of length $length');
//     }

//     return words;
//   }
// }



// // with print on debug console


// class FirestoreService {
//   final CollectionReference wordsCollection =
//       FirebaseFirestore.instance.collection('WordsListRowy');

//   Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getWords() async {
//     List<QueryDocumentSnapshot<Map<String, dynamic>>> words = [];

//     for (int length = 3; length <= 13; length++) {
//       QuerySnapshot<Object?> snapshot = await wordsCollection
//           .where('length', isEqualTo: length)
//           .limit(8)
//           .get();

//       words.addAll(snapshot.docs
//           as Iterable<QueryDocumentSnapshot<Map<String, dynamic>>>);

//       print('Fetched ${snapshot.docs.length} words of length $length');

//       for (var wordDoc in snapshot.docs) {
//         print('Word: ${wordDoc.data()}');
//       }
//     }

//     return words;
//   }

//   Future<void> deleteWords(
//       List<QueryDocumentSnapshot<Map<String, dynamic>>> words) async {
//     for (var wordDoc in words) {
//       await wordsCollection.doc(wordDoc.id).delete();
//       print('Deleted word: ${wordDoc.data()}');
//     }
//   }
// }



// // fetch all the words - did this because it was showing the same words even after restarting app


// class FirestoreService {
//   final CollectionReference wordsCollection = FirebaseFirestore.instance.collection('WordsListRowy');

//   Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getWords() async {
//     List<QueryDocumentSnapshot<Map<String, dynamic>>> words = [];

//     for (int length = 3; length <= 13; length++) {
//       QuerySnapshot<Object?> snapshot;
//       List<QueryDocumentSnapshot<Map<String, dynamic>>> batchWords = [];

//       // Fetch words in batches of 100
//       Query query = wordsCollection
//           .where('length', isEqualTo: length)
//           .limit(10);

//       // Loop to fetch all batches
//       while (true) {
//         snapshot = await query.get();
//         if (snapshot.docs.isEmpty) {
//           break;
//         }
//         batchWords.addAll(snapshot.docs as Iterable<QueryDocumentSnapshot<Map<String, dynamic>>>);
//         query = wordsCollection
//             .where('length', isEqualTo: length)
//             .startAfterDocument(snapshot.docs.last)
//             .limit(100);
//       }

//       words.addAll(batchWords);

//       print('Fetched ${batchWords.length} words of length $length');

//       for (var wordDoc in batchWords) {
//         print('Word: ${wordDoc.data()}');
//       }
//     }

//     return words;
//   }
// }



// // fetch the words in a random order so it is not the same every time


import 'dart:math' as math;

class FirestoreService {
  final CollectionReference wordsCollection =
      FirebaseFirestore.instance.collection('WordsListRowy');

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getRandomWords() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> words = [];

    for (int length = 3; length <= 13; length++) {
      QuerySnapshot<Object?> snapshot = await wordsCollection
          .where('length', isEqualTo: length)
          .get();

      // Get all documents of the current length
      List<QueryDocumentSnapshot<Object?>> documents = snapshot.docs;

      // Shuffle the documents to get a random order
      documents.shuffle(math.Random());

      // Take the first 8 shuffled documents (or less if there are fewer than 8)
      List<QueryDocumentSnapshot<Object?>> randomDocuments =
          documents.take(8).toList();

      words.addAll(randomDocuments as Iterable<QueryDocumentSnapshot<Map<String, dynamic>>>);

      // print('Fetched ${randomDocuments.length} random words of length $length');
      // for (var wordDoc in randomDocuments) {
      //   print('Word: ${wordDoc.data()}');
      // }
    }

    return words;
  }
}