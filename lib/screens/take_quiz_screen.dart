import 'package:flutter/material.dart';
import 'package:shquizzer/components/quiz_item_widget.dart';
import 'package:shquizzer/models/quiz.dart';
import 'package:shquizzer/models/quiz_item.dart';
import 'package:shquizzer/services/logger_service.dart';

class TakeQuizScreen extends StatefulWidget {
  const TakeQuizScreen({Key? key}) : super(key: key);

  @override
  State<TakeQuizScreen> createState() => _TakeQuizScreenState();
}

class _TakeQuizScreenState extends State<TakeQuizScreen> {
  int numCorrect = 0;
  int numAnswered = 0;
  bool finished = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    Quiz quiz = args['quiz'];

    return Scaffold(
      appBar: AppBar(title: Text('Quiz: ${quiz.title}'), actions: <Widget>[
        if (finished) _buildClearButton(),
        _buildFinishedButton(),
      ]),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Center(
              child: Text(
                finished
                    ? "$numCorrect of ${quiz.items.length} correct."
                    : "$numAnswered of ${quiz.items.length} answered.",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.black54,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: quiz.items.length,
              itemBuilder: (context, i) {
                QuizItem item = quiz.items.elementAt(i);
                return QuizItemWidget(
                  item: item,
                  finished: finished,
                  handleChoiceCallback: _handleChoiceMade,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinishedButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        key: const ValueKey('button.finished'),
        onPressed: finished ? null : _handleFinishedButton,
        style: ElevatedButton.styleFrom(primary: Colors.green),
        child: const Text('Finished'),
      ),
    );
  }

  Widget _buildClearButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        key: const ValueKey('button.clear'),
        onPressed: _handleClearButton,
        style: ElevatedButton.styleFrom(primary: Colors.red),
        child: const Text('Clear Answers'),
      ),
    );
  }

  void _handleFinishedButton() {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    Quiz quiz = args['quiz'];

    var correctCount = 0;
    for (QuizItem item in quiz.items) {
      if (item.isCorrect()) correctCount++;
    }

    setState(() {
      numCorrect = correctCount;
      finished = true;
    });
  }

  void _handleClearButton() {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    Quiz quiz = args['quiz'];

    setState(() {
      for (QuizItem item in quiz.items) {
        item.reset();
      }
      finished = false;
    });
  }

  void _handleChoiceMade(String value) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    Quiz quiz = args['quiz'];

    var answeredCount = 0;
    for (QuizItem item in quiz.items) {
      if (item.chosenChoiceIndex != null) answeredCount++;
    }

    setState(() {
      LoggerService().log("SETTING STATE $answeredCount");
      numAnswered = answeredCount;
    });
  }
}
