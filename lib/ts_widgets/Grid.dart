
import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  final List<int> numbers;
  final Size size;
  final Function(int) onClick;
  final Map<int, String> numberToLetter; // Add this line to receive the mapping

  const Grid(this.numbers, this.size, this.onClick, this.numberToLetter);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemCount: numbers.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final tileNumber = numbers[index];
          final letter = numberToLetter[tileNumber]; // Get the letter

          return GestureDetector(
            onTap: () {
              if (tileNumber != 0) {
                onClick(index);
              }
            },
            child: letter == null
                ? Container() // Don't render anything if letter is null
                : Container(
                    margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      border: Border.all(),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      letter,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 0, 0, 0),  // Change text color to red
                          decoration: TextDecoration.underline,  // Add an underline
                          decorationColor: Color.fromARGB(255, 255, 255, 255),  // Set the underline color to yellow
                        ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
