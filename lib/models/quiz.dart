import "package:shquizzer/models/quiz_item.dart";

class Quiz {
  String title;
  List<QuizItem> items;

  Quiz({
    required this.title,
    required this.items,
  });
}
