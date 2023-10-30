

/////////////new lvevel more increases/////////////
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:word_play_wonderland/game/figure_widget.dart';

import 'const/consts.dart';
import 'game/hidden_letter.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var characters = "abcdefghijklmnopqrstuvwxyz".toUpperCase();
  List<String> selectedChar = [];
  var tries = 0;
  var isWordGuessed = false;
  var remainingTime = 10;
  var level = 1;
  late final ValueNotifier<int> timerNotifier;

  List<String> words = ["apple", "banana", "cherry", "grape", "melon"];

  @override
  void initState() {
    super.initState();
    timerNotifier = ValueNotifier<int>(remainingTime);
    startTimer();
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerNotifier.value > 0) {
        timerNotifier.value -= 1;
      } else {
        timer.cancel();
        setState(() {
          isWordGuessed = true;
        });
      }
    });
  }

  void nextLevel() {
    setState(() {
      level++;
      remainingTime = 10;
      tries = 0;
      isWordGuessed = false;
      selectedChar.clear();
      timerNotifier.value = remainingTime;

      if (level <= words.length) {
        var word = words[level - 1].toUpperCase();
      } else {
        // All levels completed, handle this as needed
        // For example, show a game completion message or go back to the main screen
      }

      startTimer();
    });
  }

  void kmpPreprocess(String pattern, List<int> lps) {
    int length = 0;
    lps[0] = 0;

    int i = 1;
    while (i < pattern.length) {
      if (pattern[i] == pattern[length]) {
        length++;
        lps[i] = length;
        i++;
      } else {
        if (length != 0) {
          length = lps[length - 1];
        } else {
          lps[i] = 0;
          i++;
        }
      }
    }
  }

  bool kmpSearch(String text, String pattern) {
    int n = text.length;
    int m = pattern.length;
    List<int> lps = List<int>.filled(m, 0);

    kmpPreprocess(pattern, lps);

    int i = 0;
    int j = 0;
    while (i < n) {
      if (pattern[j] == text[i]) {
        i++;
        j++;
      }

      if (j == m) {
        return true; // Pattern found
      } else if (i < n && pattern[j] != text[i]) {
        if (j != 0) {
          j = lps[j - 1];
        } else {
          i++;
        }
      }
    }
    return false; // Pattern not found
  }

  @override
  void dispose() {
    timerNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var word = words[level - 1].toUpperCase();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("HANGMAN GAME"),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      figure(GameUI.hang, tries >= 0),
                      figure(GameUI.head, tries >= 1),
                      figure(GameUI.body, tries >= 2),
                      figure(GameUI.leftArm, tries >= 3),
                      figure(GameUI.rightArm, tries >= 4),
                      figure(GameUI.leftLeg, tries >= 5),
                      figure(GameUI.rightLeg, tries >= 6),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: word
                          .split("")
                          .map(
                            (e) => hiddenLetter(
                              e,
                              !selectedChar.contains(e.toUpperCase()),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Level: $level",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Remaining Time: ${timerNotifier.value}s",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  if (isWordGuessed)
                    Text(
                      "Correct Word: $word",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                crossAxisCount: 8,
                children: characters.split("").map((e) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black54,
                    ),
                    onPressed: (selectedChar.contains(e.toUpperCase()) ||
                            isWordGuessed ||
                            tries >= 6)
                        ? null
                        : () {
                            setState(() {
                              selectedChar.add(e.toUpperCase());
                              if (!word.split("").contains(e.toUpperCase())) {
                                tries++;
                              }
                              if (kmpSearch(
                                  word, selectedChar.join().toUpperCase())) {
                                isWordGuessed = true;
                                Future.delayed(Duration(seconds: 2), () {
                                  nextLevel();
                                });
                              }
                            });
                          },
                    child: Text(
                      e,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(home: GameScreen()));
// }
