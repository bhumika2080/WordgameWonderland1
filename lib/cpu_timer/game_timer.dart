// import 'dart:async';

// class GameTimer{
//   bool _isActive = false;
//   int _secondsPassed = 0;
//   late Timer _timer;
  
//   void start() {
//     if (!_isActive) {
//       _isActive = true;
//       _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//         _secondsPassed++;
//       });
//     }
//   }

//   void pause() {
//     _isActive = false;
//     _timer.cancel();
//   }

//   void reset() {
//     _isActive = false;
//     _timer.cancel();
//     _secondsPassed = 0;
//   }

//   int get secondsPassed => _secondsPassed;
// }



// // with resume

import 'dart:async';

import 'package:flutter/material.dart';

class GameTimer extends StatelessWidget{
  bool _isActive = false;
  int _secondsPassed = 0;
  late Timer _timer;
  int _lastResumeTime = 0;

  void start() {
    if (!_isActive) {
      _isActive = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _secondsPassed++;
      });
    }
  }

  void pause() {
    if (_isActive) {
      _isActive = false;
      _timer.cancel();
    }
  }

  void resume() {
    if (!_isActive) {
      _isActive = true;
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          _secondsPassed++;
        },
      );
    }
  }

  void reset() {
    _isActive = false;
    _timer.cancel();
    _secondsPassed = 0;
  }

  int get secondsPassed => _secondsPassed;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Text(
        "Time: $secondsPassed",
        style: const TextStyle(
        fontSize: 18,
        color: Colors.black, // Set text color to black
        ),
      ),
    );
  }
}
