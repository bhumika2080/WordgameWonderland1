
import 'package:flutter/material.dart';
import 'Move.dart';

class Menu extends StatelessWidget {

  Function reset;
  int move;
  int secondsPassed;
  var size;

  Menu(this.reset, this.move, this.secondsPassed, this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // ResetButton(reset, "Reset"),
          Move(move),
          // Time(secondsPassed),
        ],
      ),
    );
  }
}