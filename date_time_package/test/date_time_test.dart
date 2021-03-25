import 'package:date_time_package/date_time_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DateTime ConsoleTimeStamp', () {
    final consoleString = consoleTimeStamp;
    expect(consoleString, isNotNull);
    expect(consoleString.length, 12);
  });

  test('DateTime asKey', () {
    final dt = DateTime.now().asKey();
    final prefix = dt.substring(0, 3);
    expect(prefix, '202');
    debugPrint('DT: $dt');
  });

  test('Rounding', () {
    DateTime zego = DateTime(2020, 12, 31, 10, 15, 20, 34, 45);
    expect(zego.round(DateTimeElement.second).toIso8601String(), '2020-12-31T10:15:20.000');
    expect(zego.round(DateTimeElement.hour).toIso8601String(), '2020-12-31T10:00:00.000');
    expect(zego.round(DateTimeElement.year).toIso8601String(), '2020-01-01T00:00:00.000');
  });
  test('DateTime deltas', () {
    final element = DateTimeElement.month;
    DateTime zego = DateTime(2020, 12, 31, 10, 15, 20, 34, 45).next(element, 2);
    expect(zego.toIso8601String(), '2021-02-28T10:15:20.034045');

    zego = DateTime(2020, 10, 31, 10, 15, 20, 34, 45).next(element, 1);
    expect(zego.toIso8601String(), '2020-11-30T10:15:20.034045');
  });
}
