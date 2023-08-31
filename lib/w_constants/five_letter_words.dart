import '../firebase_queries/words.dart';

// Somewhere in your code
Future<void> someFunction() async {
  List<String> words = await fetchWordsFromFirebase();

  // Filter the words to get five-letter words
  List<String> fiveLetterWords = words.where((word) => word.length == 5).toList();

  // Now you can use the fiveLetterWords list
  print(fiveLetterWords);
}


// const List<String> fiveLetterWords = [
//   'HORSE',
//   'TIGER',
//   'SHARK',
//   'PUPPY',
//   'ZEBRA',
//   'SNAKE'
// ];