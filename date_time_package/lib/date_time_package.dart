library date_time_package;

import 'package:intl/intl.dart';

String get consoleTimeStamp => DateFormat('HH:mm:ss.SSS').format(DateTime.now().toLocal());
