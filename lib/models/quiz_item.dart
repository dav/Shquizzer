import 'package:shquizzer/services/logger_service.dart';

class QuizItem {
  String challenge;
  List<String> choices;
  int correctChoiceIndex;
  int? chosenChoiceIndex;

  QuizItem({
    required this.challenge,
    required this.choices,
    required this.correctChoiceIndex,
  });

  void choose(String value) {
    LoggerService().log("Choosing $value for $challenge");
    chosenChoiceIndex = choices.indexOf(value);
  }

  bool isCorrect() {
    return correctChoiceIndex == chosenChoiceIndex;
  }

  String? currentChoice() {
    if (chosenChoiceIndex == null) return null;

    return choices[chosenChoiceIndex!];
  }

  void reset() {
    chosenChoiceIndex = null;
  }

  void shuffleChoices() {
    String correctChoice = choices[correctChoiceIndex];
    choices.shuffle();
    correctChoiceIndex = choices.indexOf(correctChoice);
  }

  @override
  String toString() {
    if (chosenChoiceIndex != null) {
      return "$challenge: ${currentChoice()}; ${isCorrect()}";
    } else {
      return "$challenge: NO ANSWER";
    }
  }
}
