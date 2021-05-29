// Copyright 2021 LTMM. All rights reserved.
library tracers;

import 'dart:async';

import 'package:flutter/material.dart';

import 'time_marker.dart';

export 'time_marker.dart';

/// This is a [Helper] class that displays message to the console using [debugPrint].
/// The display layout is [timeStamp] [icon] [optional tag] [message]
/// NOTE: Unless set with [Log.setTrace(LogLevel baseLevel: ?);] only [Crash] and [Fix] are enabled
/// NOTE: [optional tag] is truncated to seven[7] letters
/// ```dart
/// Log.A(String, String: tag); //Logs as All Levels - lowest level
/// Log.M(String, String: tag); //Logs as Mark Level - typically related to 3rd party lib's loaded
/// Log.T(String, String: tag); //Logs as Trace Level
/// Log.V(String, String: tag); //Logs as Verbose Level
/// Log.D(String, String: tag); //Logs as Debug Level
/// Log.I(String, String: tag); //Logs as Info Level
/// Log.W(String, String: tag); //Logs as Warning Level
/// Log.E(String, String: tag); //Logs as Error Level
/// Log.F(String, String: tag); //Logs as Fix - special case for placeholder that is always displayed
/// Log.C(String, String: tag); //Logs as Crash Level - highest level
/// ```
/// NOTE: To change the logging level
/// ```dart
/// Log.setTrace(LogLevel baseLevel: ?);
/// ```
/// NOTE: Any log level [lower] then [baseLevel] is not displayed.
/// Rank lowest to highest [All, Mark, Trace, Verbose, Debug, Info, Warning, Error, Crash]
/// NOTE: Logging always displays [Crash] and [Fix] entries,
enum LogLevel {
  All,
  Mark,
  Trace,
  Verbose,
  Debug,
  Info,
  Warning,
  Error,
  Fix,
  Crash,
  None,
}

class Log {
  static A(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.All, message, tag);
  static M(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.Mark, message, tag);
  static T(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.Trace, message, tag);
  static V(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.Verbose, message, tag);
  static D(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.Debug, message, tag);
  static I(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.Info, message, tag);
  static W(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.Warning, message, tag);
  static E(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.Error, message, tag);
  static F(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.Fix, message, tag);
  static C(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.Crash, message, tag);

  static Set _setOfLogLevels = {LogLevel.Fix, LogLevel.Crash};
  static bool _logLevelsSet = false;

  static Future setTrace({required LogLevel baseLevel}) async {
    _logLevelsSet = true;
    _setOfLogLevels = Set.from(LogLevel.values);
    switch (baseLevel) {
      case LogLevel.All:
        break;
      case LogLevel.Mark:
        _setOfLogLevels.remove(LogLevel.All);
        break;
      case LogLevel.Trace:
        _setOfLogLevels.remove(LogLevel.All);
        _setOfLogLevels.remove(LogLevel.Mark);
        break;
      case LogLevel.Verbose:
        _setOfLogLevels.remove(LogLevel.All);
        _setOfLogLevels.remove(LogLevel.Mark);
        _setOfLogLevels.remove(LogLevel.Trace);
        break;
      case LogLevel.Debug:
        _setOfLogLevels.remove(LogLevel.All);
        _setOfLogLevels.remove(LogLevel.Mark);
        _setOfLogLevels.remove(LogLevel.Trace);
        _setOfLogLevels.remove(LogLevel.Verbose);
        break;
      case LogLevel.Info:
        _setOfLogLevels.remove(LogLevel.All);
        _setOfLogLevels.remove(LogLevel.Mark);
        _setOfLogLevels.remove(LogLevel.Trace);
        _setOfLogLevels.remove(LogLevel.Verbose);
        _setOfLogLevels.remove(LogLevel.Debug);
        break;
      case LogLevel.Fix:
        _setOfLogLevels.remove(LogLevel.All);
        _setOfLogLevels.remove(LogLevel.Mark);
        _setOfLogLevels.remove(LogLevel.Trace);
        _setOfLogLevels.remove(LogLevel.Verbose);
        _setOfLogLevels.remove(LogLevel.Debug);
        _setOfLogLevels.remove(LogLevel.Info);
        break;
      case LogLevel.Warning:
        _setOfLogLevels = Set.of([LogLevel.Warning, LogLevel.Error]);
        break;
      case LogLevel.Error:
        _setOfLogLevels = Set.of([LogLevel.Error]);
        break;
      case LogLevel.None:
      case LogLevel.Crash:
        _setOfLogLevels = Set();
        break;
    }

    _setOfLogLevels.addAll(Set.of([LogLevel.Fix, LogLevel.Crash]));
    _printToConsole(LogLevel.Mark, 'Set Logging to $_setOfLogLevels', null);
  }

  static void _verifyLoggingUsingMessageLevel(LogLevel level, String message, String tag) {
    if (!_logLevelsSet) debugPrint('\n\n🚦🚥🚦🚥🚦🚥🚦 Log Levels Not Set 🚦🚥🚦🚥🚦🚥🚦\n\n');
    _logLevelsSet = true;
    if (_setOfLogLevels.contains(level)) _printToConsole(level, message, tag);
  }

  static void _printToConsole(LogLevel level, String message, String? tag) {
    tag = ((tag ??= '').length <= 7 ? tag : tag.substring(0, 7)).trim();
    final timestamp = TimeMarker.consoleTimeStamp;
    final result = '|$timestamp|$tag ${level.asSymbol} $message';
    debugPrint('$result');
  }
}

extension _LogLevel on LogLevel {
  String get asSymbol {
    switch (this) {
      case LogLevel.All:
        return '🔗';
      case LogLevel.Mark:
        return '✅';
      case LogLevel.Trace:
        return '🧭';
      case LogLevel.Verbose:
        return '📣';
      case LogLevel.Debug:
        return '🐞';
      case LogLevel.Info:
        return '📝';
      case LogLevel.Fix:
        return '🚧';
      case LogLevel.Warning:
        return '🚸';
      case LogLevel.Error:
        return '❌';
      case LogLevel.Crash:
        return '🆘';
      default:
        throw FlutterError('{tracers.dart} no symbol for ${this.toString()}');
    }
  }
}
