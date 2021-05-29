import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension IntDateTimeExtension on int {
  String asMonth({String format = 'MMM'}) => (this >= DateTime.january && this <= DateTime.december)
      ? DateFormat(format).format(
          DateTime(2000, this),
        )
      : throw FlutterError('$this outside range of 1 to 12');

  String asMeridian() => (this >= 0 && this <= 23)
      ? DateFormat('a').format(
          DateTime(2000, 1, 1, this),
        )
      : throw FlutterError('$this outside range of 0 to 23');
}
