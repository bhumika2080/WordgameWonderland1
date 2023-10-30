import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  Function() reset;
  String text;

  ResetButton(this.reset, this.text);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: reset,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 124, 243, 132), // Set the button's background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text("Reset"),
      
    );
  }
}
