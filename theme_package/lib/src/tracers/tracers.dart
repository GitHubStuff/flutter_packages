// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  static A(String message, {String tag}) => _verifyLoggingUsingMessageLevel(LogLevel.All, message, tag);
  static M(String message, {String tag}) => _verifyLoggingUsingMessageLevel(LogLevel.Mark, message, tag);
  static T(String message, {String tag}) => _verifyLoggingUsingMessageLevel(LogLevel.Trace, message, tag);
  static V(String message, {String tag}) => _verifyLoggingUsingMessageLevel(LogLevel.Verbose, message, tag);
  static D(String message, {String tag}) => _verifyLoggingUsingMessageLevel(LogLevel.Debug, message, tag);
  static I(String message, {String tag}) => _verifyLoggingUsingMessageLevel(LogLevel.Info, message, tag);
  static F(String message, {String tag}) => _verifyLoggingUsingMessageLevel(LogLevel.Fix, message, tag);
  static W(String message, {String tag}) => _verifyLoggingUsingMessageLevel(LogLevel.Warning, message, tag);
  static E(String message, {String tag}) => _verifyLoggingUsingMessageLevel(LogLevel.Error, message, tag);
  static C(String message, {String tag}) => _verifyLoggingUsingMessageLevel(LogLevel.Crash, message, tag);

  static Future setTrace({@required LogLevel baseLevel}) async {
    assert(baseLevel != null);
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
    assert(message != null);
    _getSavedLevelsFromPreferences().then((Set<LogLevel> savedLevels) {
      if (savedLevels.contains(level)) _printToConsole(level, message, tag);
    });
  }

  static Future<Set<LogLevel>> _getSavedLevelsFromPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Set<LogLevel> levels = Set();
    for (LogLevel level in LogLevel.values) {
      if (level == LogLevel.None) continue;
      final key = '$_TRACE_ROOT_PREFERENCE_PRIVATE_KEY.${level.asPreferenceString}';
      final bool enabled = sharedPreferences.getBool(key) ?? false;
      if (enabled) levels.add(level);
    }
    levels.add(LogLevel.Crash);
    levels.add(LogLevel.Fix);
    return levels;
  }

  static Future<void> _saveLevelsToPreferences(Set<LogLevel> levels) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    levels.add(LogLevel.Crash);
    levels.add(LogLevel.Fix);
    for (LogLevel level in LogLevel.values) {
      if (level == LogLevel.None) continue;
      final key = '$_TRACE_ROOT_PREFERENCE_PRIVATE_KEY.${level.asPreferenceString}';
      final enabled = levels.contains(level);
      sharedPreferences.setBool(key, enabled);
    }
  }

  static void _printToConsole(LogLevel level, String message, String tag) {
    tag = ((tag ??= '').length <= 7 ? tag : tag.substring(0, 7)).trim();
    final timestamp = DateFormat('HH:mm:ss.SSS').format(DateTime.now().toLocal());
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
