import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shquizzer/models/quiz_item.dart';
import 'package:shquizzer/services/logger_service.dart';

class QuizItemWidget extends StatefulWidget {
  final QuizItem item;
  final Function(String value) handleChoiceCallback;
  final bool finished;

  const QuizItemWidget({
    required this.item,
    required this.handleChoiceCallback,
    required this.finished,
    Key? key,
  }) : super(key: key);

  @override
  State<QuizItemWidget> createState() => _QuizItemWidgetState();
}

class _QuizItemWidgetState extends State<QuizItemWidget> {
  @override
  Widget build(BuildContext context) {
    String challenge = widget.item.challenge;

    LoggerService().log("Building item widget for $challenge");

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            challenge,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          _buildChoicesListWidget(),
        ],
      ),
    );
  }

  Widget _buildChoicesListWidget() {
    handleChoiceChosen(String? value) {
      setState(() {
        if (value != null) widget.item.choose(value);
      });

      if (value != null) widget.handleChoiceCallback(value);
    }

    String? chosen = widget.item.currentChoice();

    List<Widget> choiceWidgets = [];
    for (String choice in widget.item.choices) {
      TextStyle? style;
      if (widget.finished) {
        if (chosen == choice) {
          if (widget.item.isCorrect()) {
            style = const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.green);
          } else {
            style =
                const TextStyle(fontWeight: FontWeight.bold, color: Colors.red);
          }
        }
      }

      choiceWidgets.add(RadioListTile<String>(
        title: Text(choice, style: style),
        value: choice,
        groupValue: widget.item.currentChoice(),
        onChanged: handleChoiceChosen,
      ));
    }

    return Column(
      children: choiceWidgets,
    );
  }
}
