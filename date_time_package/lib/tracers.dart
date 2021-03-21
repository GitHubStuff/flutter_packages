library date_time_packge;

import 'package:intl/intl.dart';

String get consoleTimeStamp => DateFormat('HH:mm:ss.SSS').format(DateTime.now().toLocal());
