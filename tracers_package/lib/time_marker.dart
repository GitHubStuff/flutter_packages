import 'package:date_time_package/date_time_package.dart' as DTP;
import 'package:flutter/material.dart';

class TimeMarker {
  final startTime = DateTime.now();
  TimeMarker([String header = '']) {
    final timestamp = DTP.consoleTimeStamp;
    debugPrint('Starting 🕛 $header at $timestamp');
  }
  void show([String caption = '']) {
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    final timestamp = DTP.consoleTimeStamp;
    final message = '${duration.inMilliseconds}/ms 🏁';
    final details = '\nFinished at $timestamp taking $message';
    debugPrint(caption.isEmpty ? details : '\n$caption$details');
  }
}
