import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shquizzer/models/quiz.dart';
import 'package:shquizzer/models/quiz_item.dart';
import 'package:shquizzer/services/quiz_data_service.dart';

class QuizzesScreen extends StatefulWidget {
  final String title;

  const QuizzesScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<QuizzesScreen> createState() => _QuizzesScreenState();
}

class _QuizzesScreenState extends State<QuizzesScreen> {
  late List<Quiz> _quizzes;

  @override
  void initState() {
    super.initState();

    Quiz stateCapitalQuiz = _loadStateCapitalQuiz();
    _quizzes = [stateCapitalQuiz];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: const <Widget>[]),
      body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _quizzes.length,
          itemBuilder: (context, i) {
            Quiz quiz = _quizzes.elementAt(i);
            return ListTile(
                leading: Text(quiz.title), onTap: () => _takeQuiz(quiz));
          }),
    );
  }

  void _takeQuiz(Quiz quiz) {
    Navigator.of(context).pushNamed(
      "take_quiz",
      arguments: <String, dynamic>{
        'quiz': quiz,
      },
    );
  }

  Quiz _loadStateCapitalQuiz() {
    Map<String, String> _stateCapitalMap = {};
    QuizDataService().stateCapitals().forEach((row) {
      String state = row[0];
      String capital = row[1];
      _stateCapitalMap[state] = capital;
    });

    var states = _stateCapitalMap.keys;

    List<QuizItem> _quizItems = [];
    var numChoices = 4;

    final _random = Random();

    for (var state in states) {
      String correctCapital = _stateCapitalMap[state]!;
      List<String> choices = [correctCapital];

      List<String> capitals = _stateCapitalMap.values.toList();
      capitals.remove(correctCapital);

      for (var i = 1; i < numChoices; i++) {
        String otherCapital = capitals[_random.nextInt(capitals.length)];
        capitals.remove(otherCapital);
        choices.add(otherCapital);
      }

      _quizItems.add(
          QuizItem(challenge: state, choices: choices, correctChoiceIndex: 0)
            ..shuffleChoices());
    }

    return Quiz(title: "State Capitals", items: _quizItems);
  }
}
