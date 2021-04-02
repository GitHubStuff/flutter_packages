import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension IntTimeExtension on int {
  String asMonth({String format = 'MMM'}) =>
      (this >= DateTime.january && this <= DateTime.december) ? DateFormat(format).format(DateTime(2000, this)) : throw FlutterError('$this outside range of 1 to 12');
}
