import 'dart:developer' as developer;
import 'dart:io';

class LoggerService {
  static final LoggerService _instance = LoggerService._internal();
  factory LoggerService() => _instance;

  LoggerService._internal() {
    if (testMode()) return;
  }

  void console(String message) {
    developer.log(message);
  }

  bool testMode() {
    bool terribleHackToDetectTestMode =
        Platform.environment.containsKey('FLUTTER_TEST');
    return terribleHackToDetectTestMode;
  }

  void log(String message) {
    if (testMode()) return;

    console(message);
  }
}
