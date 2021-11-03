import 'package:flutter/material.dart';
import 'package:shquizzer/screens/quizzes_screen.dart';
import 'package:shquizzer/theme/style.dart';
import 'package:shquizzer/screens/take_quiz_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shquizzer',
      theme: appTheme(),
      routes: {
        'take_quiz': (context) => const TakeQuizScreen(),
      },
      home: const QuizzesScreen(title: 'Shquizzer!'),
    );
  }
}
