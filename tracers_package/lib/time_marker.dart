import 'package:date_time_package/date_time_package.dart' as DTP;
import 'package:flutter/material.dart';

class TimeMarker {
  static void get disabled => _enabled = false;
  static void get enabled => _enabled = true;
  static bool _enabled = true;
  final startTime = DateTime.now();
  TimeMarker([String header = '']) {
    if (_enabled) {
      final timestamp = DTP.consoleTimeStamp;
      debugPrint('Starting 🕛 $header at $timestamp');
    }
  }
  void show([String caption = '']) {
    if (!_enabled) return;
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    final timestamp = DTP.consoleTimeStamp;
    final message = '${(duration.inMilliseconds / 1000.0)}/seconds 🏁';
    final details = '\nFinished at $timestamp taking $message';
    debugPrint('$caption$details');
  }
}
