// // fetch the words in a random order so it is not the same every time
import 'package:cloud_firestore/cloud_firestore.dart';
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