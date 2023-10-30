import 'dart:async';
import 'dart:math';

void main() {
  // Put your trigger logic here
  bool triggerCondition = true;

  if (triggerCondition) {
    activateRandomTimer();
  }
}

void activateRandomTimer() {
  final random = Random();
  var randomCount = random.nextInt(64) + 7; // Generates a random number between 7 and 70

  Timer.periodic(Duration(seconds: 1), (timer) {
    if (randomCount > 0) {
      print('Countdown: $randomCount');
      randomCount--;
    } else {
      timer.cancel(); // Stops the timer when it reaches the random count
      triggerEvent(); // Put your event logic here
    }
  });
}

void triggerEvent() {
  print('Event triggered!');
  // Put your event logic here
}
