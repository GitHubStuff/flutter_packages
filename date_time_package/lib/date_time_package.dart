library date_time_package;

import 'package:intl/intl.dart';

export 'src/date_time_extension.dart';
export 'src/int_time_extension.dart';

// Suitable as time stamp in the debug console
String get consoleTimeStamp => DateFormat('HH:mm:ss.SSS').format(DateTime.now().toLocal());

enum DateTimeElement {
  year,
  month,
  day,
  hour,
  minute,
  second,
  millisecond,
  microsecond,
}
