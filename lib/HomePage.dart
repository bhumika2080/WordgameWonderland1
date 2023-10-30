import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:word_play_wonderland/hangman.dart';
import 'package:word_play_wonderland/tileshifter.dart';
import 'package:word_play_wonderland/wordle.dart';

// import 'cpu_timer/game_timer.dart';
// import 'cpu_timer/timer_display.dart';

// import 'firebase_queries/read_words.dart';
// import 'firebase_queries/words.dart';

class HomePageWidget extends StatefulWidget {
  // word getting logic start
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> words;
  const HomePageWidget({Key? key, required this.words}) : super(key: key);
  // word getting logic end

  // const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // final GameTimer gameTimer = GameTimer();-+

  bool isAgainstCpuOpponent = false; // Initialize to false

  // Add a method to update the variable when the user selects the option
  void selectGameMode(bool isAgainstCpu) {
    setState(() {
      isAgainstCpuOpponent = isAgainstCpu;
    });
  }


  @override
  void initState() {
    super.initState();
    _model = HomePageModel();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          automaticallyImplyLeading: false,
          title: const Text(
            'Wordplay Wonderland',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 22,
            ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              //    ElevatedButton(
              //   onPressed: () async {
              //     // Delete the fetched words
              //     FirestoreService firestoreService = FirestoreService();
              //     await firestoreService.deleteWords(words.cast<QueryDocumentSnapshot<Map<String, dynamic>>>());

              //     // You can optionally update the UI or show a message here
              //     print('Fetched words deleted');
              //   },
              //   child: const Text('Delete Words'),
              // ),

              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 40),
                            child: PageView(
                              controller: _model.pageViewController ??=
                                  PageController(initialPage: 1),
                              scrollDirection: Axis.horizontal,
                              children: [
                                Stack(
                                  children: [
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0, 0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        // child: CachedNetworkImage(
                                        //   imageUrl:
                                        //       'https://picsum.photos/seed/606/600',
                                        //   width: 565,
                                        //   height: 532,
                                        //   fit: BoxFit.cover,
                                        // ),
                                        child: Image.asset(
                                          'assets/home_wordle.jpg', // Replace with the actual path to your local image
                                          width: 565,
                                          height: 532,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0, 0.89),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const WordleApp()),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          backgroundColor:
                                              Color.fromARGB(255, 8, 51, 92),
                                          foregroundColor: const Color.fromARGB(
                                              255, 239, 222, 222),
                                          textStyle: const TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 16,
                                          ),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text("Play Wordle"),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0, 0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          'assets/home_slidingpuzzle.jpg', // Replace with the actual path to your local image
                                          width: 565,
                                          height: 532,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0, 0.89),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Board()),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          backgroundColor:
                                              Color.fromARGB(255, 8, 51, 92),
                                          foregroundColor: const Color.fromARGB(
                                              255, 239, 222, 222),
                                          textStyle: const TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 16,
                                          ),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text("Play Tile Shifter"),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0, 0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          'assets/home_hangman.jpg', // Replace with the actual path to your local image
                                          width: 565,
                                          height: 532,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0, 0.89),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const GameScreen()),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          backgroundColor:
                                              Color.fromARGB(255, 8, 51, 92),
                                          foregroundColor: const Color.fromARGB(
                                              255, 239, 222, 222),
                                          textStyle: const TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 16,
                                          ),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text("Play Hangman"),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-1, 1),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 0, 0, 16),
                              child: smooth_page_indicator.SmoothPageIndicator(
                                controller: _model.pageViewController ??=
                                    PageController(initialPage: 1),
                                count: 3,
                                axisDirection: Axis.horizontal,
                                onDotClicked: (i) async {
                                  // yesmai ho 3rd image ma gayepaxi feri 1st image ma jana logic
                                  // if i=3:

                                  await _model.pageViewController!
                                      .animateToPage(
                                    i,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                },
                                effect: const smooth_page_indicator
                                    .ExpandingDotsEffect(
                                  expansionFactor: 3,
                                  spacing: 8,
                                  radius: 16,
                                  dotWidth: 16,
                                  dotHeight: 8,
                                  dotColor: Color.fromARGB(255, 101, 77, 143),
                                  activeDotColor:
                                      Color.fromARGB(255, 239, 10, 63),
                                  paintStyle: PaintingStyle.stroke,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  // Radio button for Single Player
                  ListTile(
                    title: const Text(
                      'Play Single Player OR',
                      style: TextStyle(
                        color: Colors.black, // Set the text color to black
                      ),
                    ),
                    leading: Radio<String>(
                      value: 'Single Player',
                      groupValue: _model.selectedGameMode,
                      onChanged: (value) {
                        setState(() {
                          _model.selectedGameMode = value;
                        });
                      },
                      activeColor:
                          Colors.black, // Set the radio button color to black
                    ),
                  ),

                  // Radio button for Against CPU Opponent
                  ListTile(
                    title: const Text(
                      'Play Against CPU Opponent',
                      style: TextStyle(
                        color: Colors.black, // Set the text color to black
                      ),
                    ),
                    leading: Radio<String>(
                      value: 'Against CPU Opponent',
                      groupValue: _model.selectedGameMode,
                      onChanged: (value) {
                        setState(() {
                          _model.selectedGameMode = value;

                          // if (value == 'Against CPU Opponent') {
                          //   // Call a function to activate the timer
                          //   gameTimer.start(); // Start the timer
                          // } else {
                          //   gameTimer.reset();
                          // }
                        });
                      },
                      activeColor:
                          Colors.black, // Set the radio button color to black
                    ),
                  ),

              // Display the timer
                  // TimerDisplay(gameTimer.secondsPassed),


                ],
              ),

// end of radio button

            ],
          ),
        ),
      ),
    );
  }
}

class HomePageModel {
  final unfocusNode = FocusNode();
  PageController? pageViewController;

  String? selectedGameMode; // property to play single or against cpu

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }


  // bool isAgainstCpuOpponent = false; // Initialize to false

  // // Add a method to update the variable when the user selects the option
  // void selectGameMode(bool isAgainstCpu) {
  //   setState(() {
  //     isAgainstCpuOpponent = isAgainstCpu;
  //   });
  // }



}
