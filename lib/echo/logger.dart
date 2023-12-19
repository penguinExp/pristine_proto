import 'dart:convert';

import 'package:flutter/foundation.dart';

///
/// EchoLogger to be a singleton
/// 1. Customizable name, can have it (name or emoji) (bg color or no color) or skip it
///

class EchoLogger {
  final String name = "echo";

  ///
  /// Log a informational message
  ///
  void info(String msg) {
    final timeStamp = _getCurrentTimeStamp();

    final fileInfo = _getSourceFileInfo();

    const getColoredName = "\x1B[104m\x1B[37m ECHO \x1B[0m";
    const getColoredLvl = "\x1b[48;5;11m\x1B[30m INFO \x1B[0m";

    final logText = "\x1b[38;5;11m $fileInfo | $timeStamp | $msg \x1B[0m";

    if (kDebugMode) {
      print('$getColoredName$getColoredLvl$logText');
    }
  }

  ///
  /// Log a warning message
  ///
  void warn(String msg) {
    final timeStamp = _getCurrentTimeStamp();

    final fileInfo = _getSourceFileInfo();

    const getColoredName = "\x1B[104m\x1B[37m ECHO \x1B[0m";
    const getColoredLvl = "\x1b[48;5;129m\x1B[37m WARN \x1B[0m";

    final logText = "\x1b[38;5;129m $fileInfo | $timeStamp | $msg \x1B[0m";

    if (kDebugMode) {
      print('$getColoredName$getColoredLvl$logText');
    }
  }

  ///
  /// Log a warning message
  ///
  void debug(Object obj) {
    // Convert the map to a JSON string with indentation
    String jsonString = jsonEncode(obj);
    // Use the Dart:convert library for formatting
    JsonEncoder encoder = const JsonEncoder.withIndent(
      '  ',
    ); // You can customize the indentation
    String prettyPrintedJson = encoder.convert(json.decode(jsonString));

    // Split the lines and add the suffix to each line
    List<String> lines = prettyPrintedJson.split('\n');
    lines = lines.map((line) => '\x1b[38;5;15m$line').toList();

    // Join the lines back together
    String finalOutput = lines.join('\n');

    final timeStamp = _getCurrentTimeStamp();

    final fileInfo = _getSourceFileInfo();

    const getColoredName = "\x1B[104m\x1B[37m ECHO \x1B[0m";
    const getColoredLvl = "\x1b[48;5;15m\x1B[30m DEBUG \x1B[0m";

    final logText = "\x1b[38;5;15m $fileInfo | $timeStamp\x1B[0m";

    if (kDebugMode) {
      print('$getColoredName$getColoredLvl$logText\n$finalOutput');
    }
  }

  ///
  /// Log an error
  ///
  void error(String msg, {Object? error, StackTrace? stackTrace}) {
    final timeStamp = _getCurrentTimeStamp();

    final fileInfo = _getSourceFileInfo();

    const getColoredName = "\x1B[104m\x1B[37m ECHO \x1B[0m";
    const getColoredLvl = "\x1b[48;5;208m\x1B[37m ERROR \x1B[0m";

    final logText = "\x1b[38;5;214m $fileInfo | $timeStamp | $msg \x1B[0m";

    final errorText = _prettifyError(error);
    final stacktrace = _prettifyStacktrace(stackTrace);

    if (kDebugMode) {
      print('$getColoredName$getColoredLvl$logText$errorText$stacktrace');
    }
  }

  ///
  /// Get current timestamp in `hh:mm:ss` format
  ///
  String _getCurrentTimeStamp() {
    final now = DateTime.now();

    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
  }

  String _getSourceFileInfo() {
    final currentStackTrace = StackTrace.current;

    final sourceInfo = _getSourceInfo(currentStackTrace);

    final fileInfo = _extractFileInfoFormSource(sourceInfo);

    return fileInfo;
  }

  String _extractFileInfoFormSource(String source) {
    // Regular expression to extract file name and line number
    RegExp regex = RegExp(r"\((.*?/([^/]+)):([0-9]+):([0-9]+)\)");

    // Match the regular expression in the stack trace
    Match? match = regex.firstMatch(source);

    if (match == null || match.groupCount < 4) {
      return 'source unknown';
    }

    final fileName = match.group(2); // Extracting only the file name part
    final lineNumber = int.parse(match.group(3)!);

    return "$fileName $lineNumber";
  }

  ///
  /// Get the source info from the current stack trace
  ///
  String _getSourceInfo(StackTrace stackTrace) {
    return stackTrace.toString().split('\n').firstWhere(
          (element) => !element.contains('EchoLogger'),
          orElse: () => 'source unknown',
        );
  }

  String _prettifyError(Object? error) {
    if (error == null) {
      return '';
    }

    const title = "\x1b[48;5;196m\x1B[30m\x1b[3m error \x1B[0m";

    return '\n$title \x1b[38;5;196m$error \x1B[0m';
  }

  String _prettifyStacktrace(StackTrace? stackTrace, {int maxLines = 5}) {
    if (stackTrace == null) {
      return '';
    }

    final stackTraceList =
        stackTrace.toString().split('\n').sublist(0, maxLines);

    final coloredSt =
        stackTraceList.map((line) => "\x1b[38;5;225m$line").toList().join('\n');

    const title = "\x1b[48;5;225m\x1B[30m\x1b[3m stacktrace \x1B[0m";

    return '\n$title \x1b[38;5;243m \n$coloredSt \x1B[0m';
  }
}
