import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../firebase_queries/words.dart';
import '../w_components/grid.dart';
import '../w_components/keyboard_row.dart';
import '../w_components/stats_box.dart';
import '../w_providers/controller.dart';
import '../w_utils/quick_box.dart';
import 'settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _word;  // code for words list from firebase
  late List<String> fiveLetterWords;

  @override
  void initState() {
    // final r = Random().nextInt(words.length);
    // _word = words[r];

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Provider.of<Controller>(context, listen: false)
    //       .setCorrectWord(word: _word);
    // });
    // super.initState();

// // code for random word from firebase start
    
  // final random = Random();
  // _word = fiveLetterWords[random.nextInt(fiveLetterWords.length)];

  // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //   Provider.of<Controller>(context, listen: false)
  //       .setCorrectWord(word: _word);
  // });

  super.initState();
  _fetchAndSelectRandomWord();
  }

  // Future<void> _fetchAndSelectRandomWord() async {
  //   _selectRandomWord();
  // }

  Future<void> _fetchAndSelectRandomWord() async {
    fiveLetterWords = await fetchWordsFromFirebase();
    fiveLetterWords = fiveLetterWords.where((word) => word.length == 5).toList();
    _selectRandomWord();
  }


  // void _selectRandomWord() {
  //   final random = Random();
  //   _word = fiveLetterWords[random.nextInt(fiveLetterWords.length)];
  //   Provider.of<Controller>(context, listen: false).setCorrectWord(word: _word);
  // }
  void _selectRandomWord() {
    final random = Random();
    _word = fiveLetterWords[random.nextInt(fiveLetterWords.length)];
    Provider.of<Controller>(context, listen: false).setCorrectWord(word: _word);
  }


// // code for random word for firebase end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle Game'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Consumer<Controller>(
            builder: (_, notifier, __) {
              if (notifier.notEnoughLetters) {
                runQuickBox(context: context, message: 'Not Enough Letters');
              }
              if (notifier.gameCompleted) {
                if (notifier.gameWon) {
                  if (notifier.currentRow == 6) {
                    runQuickBox(context: context, message: 'Phew!');
                  } else {
                    runQuickBox(context: context, message: 'Splendid!');
                  }
                } else {
                  runQuickBox(context: context, message: notifier.correctWord);
                }
                Future.delayed(
                  const Duration(milliseconds: 4000),
                  () {
                    if (mounted) {
                      showDialog(
                          context: context, builder: (_) => const StatsBox());
                    }
                  },
                );
              }
              return IconButton(
                  onPressed: () async {
                    showDialog(
                        context: context, builder: (_) => const StatsBox());
                  },
                  icon: const Icon(Icons.bar_chart_outlined));
            },
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Settings()));
              },
              icon: const Icon(Icons.settings)),

          // rules button
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Settings()));
              },
              icon: const Icon(Icons.settings)),
          // rules button end
        ],
      ),
      body: const Column(
        children: [
          Divider(
            height: 2,
            thickness: 2,
          ),
          Expanded(flex: 12, child: Grid()),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  KeyboardRow(
                    min: 1,
                    max: 10,
                  ),
                  KeyboardRow(
                    min: 11,
                    max: 19,
                  ),
                  KeyboardRow(
                    min: 20,
                    max: 29,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
