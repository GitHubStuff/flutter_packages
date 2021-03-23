import 'package:date_time_package/date_time_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DateTime ConsoleTimeStamp', () {
    final consoleString = consoleTimeStamp;
    expect(consoleString, isNotNull);
    expect(consoleString.length, 12);
  });

  test('DateTime as Key', () {
    final dt = DateTime.now().asKey();
    final prefix = dt.substring(0, 3);
    expect(prefix, '202');
    debugPrint('DT: $dt');
  });
}
