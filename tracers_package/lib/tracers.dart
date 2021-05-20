library tracers;

// Copyright 2021 LTMM. All rights reserved.

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:date_time_package/date_time_package.dart' as DTP;
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:xfer/xfer.dart';

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
/// Log.C(String, String: tag); //Logs as Crash Level - highest level
/// Log.F(String, String: tag); //Logs as Fix - special case for placeholder that is always displayed
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
  Crash,
  Fix,
  None,
}

class Log {
  static A(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.All, message, tag);
  static M(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.Mark, message, tag);
  static T(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.Trace, message, tag);
  static V(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.Verbose, message, tag);
  static D(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.Debug, message, tag);
  static I(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.Info, message, tag);
  static F(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.Fix, message, tag);
  static W(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.Warning, message, tag);
  static E(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.Error, message, tag);
  static C(String message, {String tag = ''}) => _verifyLoggingUsingMessageLevel(LogLevel.Crash, message, tag);

  static bool _setTraceFlag = false;

  static Future setTrace({required LogLevel baseLevel}) async {
    _setTraceFlag = true;
    Set<LogLevel> adjustableSetOfLogLevels = Set.from(LogLevel.values);
    switch (baseLevel) {
      case LogLevel.All:
        break;
      case LogLevel.Mark:
        adjustableSetOfLogLevels.remove(LogLevel.All);
        break;
      case LogLevel.Trace:
        adjustableSetOfLogLevels.remove(LogLevel.All);
        adjustableSetOfLogLevels.remove(LogLevel.Mark);
        break;
      case LogLevel.Verbose:
        adjustableSetOfLogLevels.remove(LogLevel.All);
        adjustableSetOfLogLevels.remove(LogLevel.Mark);
        adjustableSetOfLogLevels.remove(LogLevel.Trace);
        break;
      case LogLevel.Debug:
        adjustableSetOfLogLevels.remove(LogLevel.All);
        adjustableSetOfLogLevels.remove(LogLevel.Mark);
        adjustableSetOfLogLevels.remove(LogLevel.Trace);
        adjustableSetOfLogLevels.remove(LogLevel.Verbose);
        break;
      case LogLevel.Info:
        adjustableSetOfLogLevels.remove(LogLevel.All);
        adjustableSetOfLogLevels.remove(LogLevel.Mark);
        adjustableSetOfLogLevels.remove(LogLevel.Trace);
        adjustableSetOfLogLevels.remove(LogLevel.Verbose);
        adjustableSetOfLogLevels.remove(LogLevel.Debug);
        break;
      case LogLevel.Fix:
        adjustableSetOfLogLevels.remove(LogLevel.All);
        adjustableSetOfLogLevels.remove(LogLevel.Mark);
        adjustableSetOfLogLevels.remove(LogLevel.Trace);
        adjustableSetOfLogLevels.remove(LogLevel.Verbose);
        adjustableSetOfLogLevels.remove(LogLevel.Debug);
        adjustableSetOfLogLevels.remove(LogLevel.Info);
        break;
      case LogLevel.Warning:
        adjustableSetOfLogLevels = Set.of([LogLevel.Warning, LogLevel.Error]);
        break;
      case LogLevel.Error:
        adjustableSetOfLogLevels = Set.of([LogLevel.Error]);
        break;
      case LogLevel.None:
      case LogLevel.Crash:
        adjustableSetOfLogLevels = Set();
        break;
    }

    adjustableSetOfLogLevels.addAll(Set.of([LogLevel.Fix, LogLevel.Crash]));
    await _saveLevelsToPreferences(adjustableSetOfLogLevels);
    _printToConsole(LogLevel.Mark, 'Set Logging to $adjustableSetOfLogLevels', null);
  }

  static const _TRACE_ROOT_PREFERENCE_PRIVATE_KEY = 'com.icodeforyou.tracer';

  static void _verifyLoggingUsingMessageLevel(LogLevel level, String message, String tag) {
    _getSavedLevelsFromPreferences().then((Set<LogLevel> savedLevels) {
      final timestamp = DTP.consoleTimeStamp;
      if (!_setTraceFlag) debugPrint('|$timestamp| 🔕 TRACERS LEVEL NOT SET 🔕');
      _setTraceFlag = true;
      if (savedLevels.contains(level)) _printToConsole(level, message, tag);
    });
  }

  static Future<Set<LogLevel>> _getSavedLevelsFromPreferences() async {
    Xfer xfer = Xfer(trace: true);
    Set<LogLevel> levels = Set();
    for (LogLevel level in LogLevel.values) {
      if (level == LogLevel.None) continue;
      final key = '$_TRACE_ROOT_PREFERENCE_PRIVATE_KEY.${level.asPreferenceString}';
      final Either<XferFailure, XferResponse> result = await xfer.get(
        'preference://$key',
        value: false,
      );
      result.fold(
        (l) => null,
        (response) {
          if (response.data<bool>()) levels.add(level);
        },
      );
    }
    levels.add(LogLevel.Crash);
    levels.add(LogLevel.Fix);
    return levels;
  }

  static Future<void> _saveLevelsToPreferences(Set<LogLevel> levels) async {
    Xfer xfer = Xfer();
    levels.add(LogLevel.Crash);
    levels.add(LogLevel.Fix);
    for (LogLevel level in LogLevel.values) {
      if (level == LogLevel.None) continue;
      final key = '$_TRACE_ROOT_PREFERENCE_PRIVATE_KEY.${level.asPreferenceString}';
      final enabled = levels.contains(level);
      final Either<XferFailure, XferResponse> result = await xfer.post(
        'preference://$key',
        value: enabled,
      );
    }
  }

  static void _printToConsole(LogLevel level, String message, String? tag) {
    tag = ((tag ??= '').length <= 7 ? tag : tag.substring(0, 7)).trim();
    final timestamp = DTP.consoleTimeStamp;
    final result = '|$timestamp|$tag ${level.asSymbol} $message';
    debugPrint('$result');
  }
}

extension _LogLevel on LogLevel {
  String get asPreferenceString => EnumToString.convertToString(this);

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

class TimeMarker {
  final startTime = DateTime.now();
  void show([String caption = 'Elapsed']) {
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    final timestamp = DTP.consoleTimeStamp;
    final message = '${duration.inSeconds}.${duration.inMilliseconds}';
    debugPrint(caption.isEmpty ? '$timestamp => ⏱ $message' : '$timestamp => ⏱ $caption $message');
  }
}
