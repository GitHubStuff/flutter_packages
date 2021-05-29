import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeMarker {
  static String get consoleTimeStamp => DateFormat('HH:mm:ss.SSS').format(DateTime.now().toLocal());

  static void get disabled => _enabled = false;
  static void get enabled => _enabled = true;
  static bool get status => _enabled;
  static bool _enabled = true;
  static bool _first = true;
  final startTime = DateTime.now();
  TimeMarker([String header = '']) {
    if (_first && _enabled) debugPrint('\n\n🟩🟩🟩🟩🟩 TimeMarkers are enabled!! {TimeMarker.disabled to disable 🟩🟩🟩🟩\n\n');
    if (_first && !_enabled) debugPrint('\n\n🟥🟥🟥🟥🟥 TimeMarkers are disabled!! {TimeMarker.enabled to enable 🟥🟥🟥🟥\n\n');
    _first = false;
    if (_enabled) {
      final timestamp = consoleTimeStamp;
      debugPrint('Starting 🕛 $header at $timestamp');
    }
  }

  static TimeMarker? builder([bool trace = false, String caption = '']) => (trace) ? TimeMarker(caption) : null;

  void show([String caption = '']) {
    if (!_enabled) return;
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    final timestamp = consoleTimeStamp;
    final message = '${(duration.inMilliseconds / 1000.0)}/seconds 🏁';
    final details = '\nFinished at $timestamp taking $message';
    debugPrint('$caption$details');
  }
}
