import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  VoidCallback reset;
  String text;

  ResetButton(this.reset, this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: reset,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      child: const Text("Reset"),
    );
  }
}