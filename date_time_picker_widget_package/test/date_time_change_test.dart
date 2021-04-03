import 'package:date_time_picker_widget_package/date_time_picker_widget_package.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

void main() {
  test('In/Out of leap year', () {
    final oldDateTime = DateTime(2020, 2, 29, 11, 15, 21);
    final newDateTime = DateTime(2021, 2, 28, 13, 15, 20);
    debugPrint('OLD: $oldDateTime NEW: $newDateTime');
    final dateTimeChange = DateTimeChange(oldDateTime: oldDateTime, newDateTime: newDateTime);
    debugPrint('old: ${dateTimeChange.oldDateTime} new: ${dateTimeChange.newDateTime}');
    expect(dateTimeChange.yearChanged, true);
    expect(dateTimeChange.monthChanged, false);
    expect(dateTimeChange.dayChanged, true);
    expect(dateTimeChange.hourChanged, true);
    expect(dateTimeChange.minuteChanged, false);
    expect(dateTimeChange.secondChanged, true);
    expect(dateTimeChange.meridanChanged, true);
    expect(dateTimeChange.dayCountChanged, true);
    expect(dateTimeChange.numberOfDays, 28);
  });
  test('Jump from Oct to Dec to make sure number of days does not change', () {
    final oldDateTime = DateTime(2020, 10, 29, 9, 11, 21);
    final newDateTime = DateTime(2020, 12, 29, 5, 11, 21);
    final dateTimeChange = DateTimeChange(oldDateTime: oldDateTime, newDateTime: newDateTime);
    expect(dateTimeChange.yearChanged, false);
    expect(dateTimeChange.monthChanged, true);
    expect(dateTimeChange.dayChanged, false);
    expect(dateTimeChange.hourChanged, true);
    expect(dateTimeChange.minuteChanged, false);
    expect(dateTimeChange.secondChanged, false);
    expect(dateTimeChange.meridanChanged, false);
    expect(dateTimeChange.dayCountChanged, false);
    expect(dateTimeChange.numberOfDays, 31);
  });

  test('Jump from Oct to Nov to make sure day does not change but day count does', () {
    final oldDateTime = DateTime(2020, 10, 29, 14, 15, 21);
    final newDateTime = DateTime(2020, 11, 29, 10, 15, 21);
    final dateTimeChange = DateTimeChange(oldDateTime: oldDateTime, newDateTime: newDateTime);
    expect(dateTimeChange.yearChanged, false);
    expect(dateTimeChange.monthChanged, true);
    expect(dateTimeChange.dayChanged, false);
    expect(dateTimeChange.hourChanged, true);
    expect(dateTimeChange.minuteChanged, false);
    expect(dateTimeChange.secondChanged, false);
    expect(dateTimeChange.meridanChanged, true);
    expect(dateTimeChange.dayCountChanged, true);
    expect(dateTimeChange.numberOfDays, 30);
  });
}
