import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class SimpleLogPrinter extends LogPrinter {
  SimpleLogPrinter();

  @override
  List<String> log(LogEvent event) {
    final now = DateTime.now();
    final timeString = now.toIso8601String();
    final levelString = event.level.toString().split('.').last.toUpperCase();

    return ['$timeString [$levelString] ${event.message}'];
  }
}

final logger = Logger(
  level: kReleaseMode ? Level.warning : Level.debug,
  printer: SimpleLogPrinter(),
);
