import 'package:date_time_package/date_time_package.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

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
    expect(zego.daysInTheMonth, 31);
  });
  test('DateTime deltas', () {
    final element = DateTimeElement.month;
    // Dec 31 + 2 months => Feb 28th
    DateTime zego = DateTime(2020, 12, 31, 10, 15, 20, 34, 45).next(element, 2);
    expect(zego.toIso8601String(), '2021-02-28T10:15:20.034045');
    expect(zego.daysInTheMonth, 28);

    zego = DateTime(2020, 10, 31, 10, 15, 20, 34, 45).next(element, 1);
    expect(zego.toIso8601String(), '2020-11-30T10:15:20.034045');
    expect(zego.daysInTheMonth, 30);

    zego = DateTime(2020, 2, 29, 0, 0, 0, 0, 0).next(DateTimeElement.year, 1);
    expect(zego.toIso8601String(), '2021-02-28T00:00:00.000');
    expect(zego.daysInTheMonth, 28);
  });

  test('DateTime leap year oddities', () {
    // Feb 29th of a leap year then advance a year => Feb 28th {not a leap year}
    DateTime zego = DateTime(2020, 2, 29, 0, 0, 0, 0, 0).next(DateTimeElement.year, 1);
    expect(zego.toIso8601String(), '2021-02-28T00:00:00.000');
    expect(zego.daysInTheMonth, 28);

    // Dec 31 + 2 months(into a leap year) => Feb 29th
    zego = DateTime(2019, 12, 31, 10, 15, 20, 34, 45).next(DateTimeElement.month, 2);
    expect(zego.toIso8601String(), '2020-02-29T10:15:20.034045');
    expect(zego.daysInTheMonth, 29);
  });

  test('Days in month', () {
    expect(() => DateTimeExtension.daysInMonth(14, year: 2020), throwsArgumentError);
    expect(DateTimeExtension.daysInMonth(DateTime.january, year: 2020), 31);
    expect(DateTimeExtension.daysInMonth(DateTime.february, year: 2020), 29);
    expect(DateTimeExtension.daysInMonth(DateTime.february, year: 2021), 28);
    expect(DateTimeExtension.daysInMonth(DateTime.february, year: 2022), 28);
    expect(DateTimeExtension.daysInMonth(DateTime.february, year: 2023), 28);
    expect(DateTimeExtension.daysInMonth(DateTime.february, year: 2024), 29);
    expect(DateTimeExtension.daysInMonth(DateTime.february, year: 2025), 28);
    expect(DateTimeExtension.daysInMonth(DateTime.february, year: 2026), 28);
    expect(DateTimeExtension.daysInMonth(DateTime.february, year: 2027), 28);
    expect(DateTimeExtension.daysInMonth(DateTime.march, year: 2020), 31);
    expect(DateTimeExtension.daysInMonth(DateTime.april, year: 2020), 30);
    expect(DateTimeExtension.daysInMonth(DateTime.may, year: 2020), 31);
    expect(DateTimeExtension.daysInMonth(DateTime.june, year: 2020), 30);
    expect(DateTimeExtension.daysInMonth(DateTime.july, year: 2020), 31);
    expect(DateTimeExtension.daysInMonth(DateTime.august, year: 2020), 31);
    expect(DateTimeExtension.daysInMonth(DateTime.september, year: 2020), 30);
    expect(DateTimeExtension.daysInMonth(DateTime.october, year: 2020), 31);
    expect(DateTimeExtension.daysInMonth(DateTime.november, year: 2020), 30);
    expect(DateTimeExtension.daysInMonth(DateTime.december, year: 2020), 31);
  });
  test('Check for leap years', () {
    expect(DateTimeExtension.isLeapYear(2000), true);
    expect(DateTimeExtension.isLeapYear(1900), false);
    expect(DateTimeExtension.isLeapYear(1800), false);
    expect(DateTimeExtension.isLeapYear(2020), true);
    expect(DateTimeExtension.isLeapYear(2021), false);
    expect(DateTimeExtension.isLeapYear(2022), false);
    expect(DateTimeExtension.isLeapYear(2023), false);
    expect(DateTimeExtension.isLeapYear(2024), true);
    expect(DateTimeExtension.isLeapYear(2025), false);
    expect(DateTimeExtension.isLeapYear(2026), false);
    expect(DateTimeExtension.isLeapYear(2027), false);
    expect(DateTimeExtension.isLeapYear(2028), true);
    expect(DateTimeExtension.isLeapYear(2029), false);
    expect(DateTimeExtension.isLeapYear(2030), false);
  });
}
