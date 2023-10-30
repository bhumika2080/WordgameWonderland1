


// // app bar title but prettier(?)
import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  const MyTitle(Size size);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Sliding Puzzle",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 72, 57, 47), // Customize the background color
      centerTitle: true, // Center the title text
      // elevation: 0, // Remove the shadow
    );
  }
}
