// import 'package:flutter/material.dart';

// class TimerDisplay extends StatelessWidget {
//   final int secondsPassed;

//   TimerDisplay(this.secondsPassed);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       "Time: $secondsPassed",
//       style: const TextStyle(
//         fontSize: 18,
//         color: Colors.black, // Set text color to black
//       ),
//     );
//   }
// }



// // the display of the time changes along with the time change, instead of being static

import 'dart:async';

import 'package:flutter/material.dart';

class TimerDisplay extends StatefulWidget {
  final int initialSeconds;

  TimerDisplay(this.initialSeconds);

  @override
  _TimerDisplayState createState() => _TimerDisplayState();
}

class _TimerDisplayState extends State<TimerDisplay> {
  late Stream<int> timerStream;
  late StreamSubscription<int> timerSubscription;
  int secondsPassed = 0;

  @override
  void initState() {
    super.initState();
    secondsPassed = widget.initialSeconds;
    timerStream = Stream.periodic(Duration(seconds: 1), (x) => x).takeWhile((x) => secondsPassed < 40);
    timerSubscription = timerStream.listen((seconds) {
      setState(() {
        secondsPassed = seconds;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "Time: $secondsPassed",
      style: TextStyle(
        fontSize: 18,
        decoration: TextDecoration.underline,
        color: Colors.black, // Change the text color to black
      ),
    );
  }

  @override
  void dispose() {
    timerSubscription.cancel();
    super.dispose();
  }
}
