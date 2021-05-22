import 'package:date_time_package/date_time_package.dart' as DTP;
import 'package:flutter/material.dart';

class TimeMarker {
  final startTime = DateTime.now();
  TimeMarker([String header = '']) {
    debugPrint('Starting 🕛 $header');
  }
  void show([String caption = '']) {
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    final timestamp = DTP.consoleTimeStamp;
    final message = '${duration.inMilliseconds}/ms 🏁';
    debugPrint(caption.isEmpty ? '\n$timestamp Finished In: $message' : '$timestamp\n $caption\n Finished In $message\n');
  }
}
