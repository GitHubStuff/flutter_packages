// import 'package:date_time_package/date_time_package.dart';
// import 'package:intl/intl.dart';

// class DateTimeChange {
//   late final DateTime oldDateTime;
//   late final DateTime newDateTime;
//   DateTimeChange({required DateTime oldDateTime, required DateTime newDateTime}) {
//     this.oldDateTime = oldDateTime.round(DateTimeElement.second);
//     this.newDateTime = newDateTime.round(DateTimeElement.second);
//   }

//   bool get yearChanged => oldDateTime.year != newDateTime.year;
//   bool get monthChanged => oldDateTime.month != newDateTime.month;
//   bool get dayChanged => oldDateTime.day != newDateTime.day;
//   bool get hourChanged => oldDateTime.hour != newDateTime.hour;
//   bool get minuteChanged => oldDateTime.minute != newDateTime.minute;
//   bool get secondChanged => oldDateTime.second != newDateTime.second;
//   bool get meridanChanged => DateFormat('a').format(oldDateTime) != DateFormat('a').format(newDateTime);
//   bool get dayCountChanged => oldDateTime.daysInTheMonth != numberOfDays;
//   int get numberOfDays => newDateTime.daysInTheMonth;
// }
