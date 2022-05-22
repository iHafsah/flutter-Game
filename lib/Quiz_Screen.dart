import 'dart:math';
import 'package:flags_app/Result_Screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Quiz_Screen extends StatefulWidget {
  const Quiz_Screen();

  @override
  State<Quiz_Screen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<Quiz_Screen> {
  List<String> countries = [
    "Estonia",
    "France",
    "Germany",
    "Ireland",
    "Italy",
    "Monaco",
    "Nigeria",
    "Poland",
    "Russia",
    "Spain",
    "UK",
    "US",
  ];

  int num = Random().nextInt(3);
  int correctAnswers = 0;
  int wrongAnswers = 0;

  @override
  void initState() {
    super.initState();
    countries.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                "Guess The Flag? ",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              Text(
                countries[num],
                style: const TextStyle(
                  fontSize: 34,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              for (int i = 0; i < 3; i++)
                FlagButton(
                  name: countries[i],
                  onPressed: () {
                    if (num == i) {
                      Fluttertoast.showToast(
                          msg: "Correct Answer", backgroundColor: Colors.green);
                      correctAnswers++;
                    } else {
                      Fluttertoast.showToast(
                          msg: "Wrong Answer", backgroundColor: Colors.red);
                      wrongAnswers++;
                    }
                    setState(() {
                      countries.shuffle();
                      num = Random().nextInt(3);
                    });
                  },
                ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(
                        correctAnswers: correctAnswers,
                        wrongAnswers: wrongAnswers,
                      ),
                    ),
                  );
                },
                child: const Text("Result"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FlagButton extends StatelessWidget {
  const FlagButton({
    Key? key,
    required this.name,
    required this.onPressed,
  }) : super(key: key);

  final String name;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Image.asset(
        "assets/countries/$name.png",
        height: 150,
      ),
    );
  }
}
