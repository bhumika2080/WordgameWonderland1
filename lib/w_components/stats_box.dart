import 'package:flutter/material.dart';

// import '../main.dart';
import '../w_constants/answer_stages.dart';
import '../w_data/keys_map.dart';
import '../w_utils/calculate_stats.dart';
import '../wordle.dart';
import 'stats_tile.dart';

class StatsBox extends StatelessWidget {
  const StatsBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
              alignment: Alignment.centerRight,
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: const Icon(Icons.clear)),
          const Expanded(
              child: Text(
            'STATISTICS',
            textAlign: TextAlign.center,
          )),
          Expanded(
            child: FutureBuilder(
              future: getStats(),
              builder: (context, snapshot) {
                List<String> results = ['0', '0', '0', '0', '0'];
                if (snapshot.hasData) {
                  results = snapshot.data as List<String>;
                }
                return Row(
                  children: [
                    StatsTile(heading: 'Played', value: int.parse(results[0])),
                    StatsTile(heading: 'Win %', value: int.parse(results[2])),
                    StatsTile(
                        heading: 'Current\nStreak',
                        value: int.parse(results[3])),
                    StatsTile(
                        heading: 'Max\nStreak', value: int.parse(results[4])),
                  ],
                );
              },
            ),
          ),
          Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    // Provider.of<Controller>(context, listen: false).resetTimer();
                    keysMap.updateAll(
                        (key, value) => value = AnswerStage.notAnswered);

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const WordleApp()),
                        (route) => false);
                  },
                  child: const Text(
                    'Replay',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  )))
        ],
      ),
    );
  }
}
