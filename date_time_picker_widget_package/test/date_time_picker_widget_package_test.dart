//import 'package:tracers/tracers.dart';

import 'package:date_time_picker_widget_package/src/cubit/date_time_cubit.dart';
import 'package:test/test.dart';

void main() {
  test('Setup of Cubit', () {
    final cubit = DateTimeCubit();
    final now = DateTime.now().toUtc().toIso8601String().substring(0, 19);
    final dateTime = cubit.dateTime;
    expect(now, dateTime.toIso8601String().substring(0, 19));
    // final calculator = Calculator();
    // expect(calculator.addOne(2), 3);
    // expect(calculator.addOne(-7), -6);
    // expect(calculator.addOne(0), 1);
    // expect(() => calculator.addOne(null), throwsNoSuchMethodError);
  });

  test('Move Year', () {
    final cubit = DateTimeCubit();
    final now = DateTime.now().toUtc();
    final dateTime = cubit.dateTime;
    expect(now.toIso8601String().substring(0, 19), dateTime.toIso8601String().substring(0, 19));
    final newYear = now.year + 3;
    cubit.changeYear(newYear);
    final newDateTime = cubit.dateTime;
    expect(newDateTime.year, newYear);
  });

  test('Feb 29 to non-leap year', () {
    final base = DateTime.utc(2020, 2, 29);
    expect(base.toIso8601String(), '2020-02-29T00:00:00.000Z');
    final cubit = DateTimeCubit(base);
    expect(cubit.dateTime.toIso8601String(), '2020-02-29T00:00:00.000Z');
    cubit.changeYear(2021);
    expect(cubit.dateTime.toIso8601String(), '2021-02-29T00:00:00.000Z');
  });
}
