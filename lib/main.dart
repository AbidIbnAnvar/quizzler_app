import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'edit_questions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
        dialogTheme: DialogTheme(
          backgroundColor:
              Colors.grey[900], // Change the background color of the dialog
          titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold), // Change the title text color
          contentTextStyle: TextStyle(color: Colors.white),
          // Change the content text color
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Quizzler()),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Quizzler extends StatefulWidget {
  const Quizzler({super.key});

  @override
  State<Quizzler> createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  String question = '';
  String answer = '';
  int correct = 0;
  int wrong = 0;
  int score = 0;
  List<String> options = [];
  Map<String, bool> questionAnswers = {
    'The longest recorded flight of a chicken is 13 seconds.': true,
    'Humans can breathe and swallow at the same time.': false,
    'A group of flamingos is called a "parliament.': false,
    'Sharks are mammals.': false,
    'Honey never spoils.': true,
    'Bananas grow on trees.': false,
    'The Great Wall of China is visible from space with the naked eye.': false,
    'There are more stars in the universe than grains of sand on all the world\'s beaches.':
        true,
    'The shortest war in history lasted only 38 minutes.': true,
    'The Eiffel Tower can be 15 cm taller during the summer.': true,
    'The capital of Australia is Sydney.': false,
    'A day on Venus is longer than a year on Venus.': true,
    'Octopuses have three hearts.': true,
    'Goldfish only have a three-second memory.': false,
    'The inventor of the Pringles can is now buried in one.': true,
    'There are more fake flamingos in the world than real ones.': true,
    'The human nose can distinguish at least 1 trillion different odors.': true,
    'Lightning never strikes the same place twice.': false,
    'Bulls are colorblind.': true,
    'A "jiffy" is an actual unit of time.': true,
    'An ostrich\'s eye is bigger than its brain.': true,
    'The moon is perfectly round.': false,
    'Humans share 50% of their DNA with bananas.': true,
    'There are more trees on Earth than stars in the Milky Way galaxy.': true,
    'The Great Wall of China is one continuous wall.': false,
    'Adult humans have fewer bones than babies.': true,
    'A crocodile cannot stick its tongue out.': true,
    'Venus is the hottest planet in our solar system.': true,
    'Elephants are the only mammals that can’t jump.': true,
    'Humans have five senses.': false,
  };
  List<Icon> scoreKeeper = [];

  @override
  void initState() {
    super.initState();
    question = getRandomKey(questionAnswers);
  }

  List<String> questionsList = [];
  String getRandomKey(Map<String, bool> map) {
    questionsList = map.keys.toList();

    // Generate a random index
    Random random = Random();
    int randomIndex = random.nextInt(questionsList.length);

    // Return the key at the random index
    return questionsList[randomIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Correct: $correct',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                'Wrong: $wrong',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                'Score: ${(correct / (correct + wrong)).toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                question,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  side: BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditQuestions(
                                questionAnswers: questionAnswers,
                              )));
                },
                child: Icon(
                  Icons.edit,
                  size: 20,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  side: BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  foregroundColor: Colors.redAccent,
                ),
                onPressed: () {
                  setState(() {
                    correct = wrong = 0;
                    scoreKeeper.clear();
                  });
                },
                child: Icon(
                  CupertinoIcons.restart,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: TextButton(
              onPressed: () {
                setState(() {
                  if (scoreKeeper.length == 14) {
                    scoreKeeper.removeAt(0);
                  }
                  if (questionAnswers[question] == true) {
                    correct++;
                    scoreKeeper.add(
                      Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    );
                  } else {
                    wrong++;
                    scoreKeeper.add(
                      Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    );
                  }
                  question = getRandomKey(questionAnswers);
                });
              },
              child: Text(
                'True',
                style: TextStyle(fontSize: 20),
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  if (scoreKeeper.length == 14) {
                    scoreKeeper.removeAt(0);
                  }
                  if (questionAnswers[question] == false) {
                    correct++;
                    scoreKeeper.add(
                      Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    );
                  } else {
                    wrong++;
                    scoreKeeper.add(
                      Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    );
                  }
                  question = getRandomKey(questionAnswers);
                });
              },
              child: Text(
                'False',
                style: TextStyle(fontSize: 20),
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
          ),
        ),
        Row(children: [
          // Text(
          //   'SCORE:',
          //   style: TextStyle(color: Colors.white),
          // ),
          Row(
            children: scoreKeeper,
          ),
        ])
      ],
    );
  }
}

/*
TODO:
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
