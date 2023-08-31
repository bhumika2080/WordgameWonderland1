import 'package:flutter/material.dart';

class GridButton extends StatelessWidget {
  final VoidCallback click;
  final String text;

  const GridButton(this.text, this.click, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: text == '' ? const Color.fromARGB(0, 255, 255, 255) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: click,
      child: Text(
        text,
        style: TextStyle(
          color: text == '' ? const Color.fromARGB(0, 255, 255, 255) : Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
