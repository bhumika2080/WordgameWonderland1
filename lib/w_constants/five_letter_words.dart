import '../firebase_queries/words.dart';

// Somewhere in your code
Future<void> someFunction() async {
  List<String> words = (await fetchWordsFromFirebase()).cast<String>();

  // Filter the words to get five-letter words
  List<String> fiveLetterWords = words.where((word) => word.length == 5).toList();

  // Now you can use the fiveLetterWords list
  print(fiveLetterWords);
}



// // trying and failing to fix it
// import '../firebase_queries/words.dart';

// Future<void> someFunction() async {
//   List<WordData> wordDataList = await fetchWordsFromFirebase();

//   // Check if the list is empty before accessing its elements
//   if (wordDataList.isEmpty) {
//     print("The wordDataList is empty.");
//     return; // Exit the function to avoid further processing
//   }



//   // Filter the words to get five-letter words and make them uppercase
//   List<String> fiveLetterWords = wordDataList
//       .where((wordData) => wordData.word.length == 5)
//       .map((wordData) => wordData.word.toUpperCase())
//       .toList();

//   // Now you can use the fiveLetterWords list
//   print(fiveLetterWords);
// }





// //another try by chatgpt, clean slate?
// import 'package:cloud_firestore/cloud_firestore.dart';

// Future<List<String>> fetchFiveLetterWordsFromFirebase() async {
//   try {
//     final QuerySnapshot<Object?> snapshot =
//         await FirebaseFirestore.instance.collection('WordsListRowy').get();

//     final List<String> fiveLetterWords = [];

//     for (final wordDoc in snapshot.docs) {
//       final String word = wordDoc['lemma'].toString().toUpperCase();
//       if (word.length == 5) {
//         fiveLetterWords.add(word);
//       }
//     }

//     return fiveLetterWords;
//   } catch (e) {
//     print("Error fetching words: $e");
//     return []; // Return an empty list in case of an error
//   }
// }

// Future<void> someFunction() async {
//   List<String> fiveLetterWords = await fetchFiveLetterWordsFromFirebase();

//   // Now you can use the fiveLetterWords list, which contains five-letter words in uppercase
//   print(fiveLetterWords);
// }












