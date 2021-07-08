# date_time_intervals

Package that translates two DateTime objects into readable items such as:

- years between DateTimes
- months between DateTimes
- days between DateTimes
- hours between DateTimes
- minutes between DateTimes
- seconds between DateTimes

***NOTE:***

Because the day count for a year can vary because of leap years, and some months have 28, 29, 30, 31 days intervales that
make requests with CalendarItems .years, .month include are not to the second percise, but are very, very good approximations.

If the CalendarItems are only .days, .hours, minutes, .seconds {or permuations} these intervals are exact.

## Getting Started

Enums to define properties of the interval markers

```dart
enum CalendarDirection {
  between,
  sinceEnd,
  untilEnd,
}

/// Helpers:

// Turns the set of CalendarItem(s) into a String that can be used as a tag in something like SQLite, or MongoDB, etc

String calendarItemsAsString(Set<CalendarItem> items)

// Parses the string created with 'calendarItemsAsString' and returns set of DataItems

Set<CalendarItem> calendarItemsFrom({required String string})
```

### DateTimeIntervals

Create an instance:

```dart
DateTimeIntervals({
    Set<DateTimeElement?> setOfCalendarItems = AllCalendarItems,
    @required DateTime? startEvent,
    DateTime? endEvent,
  })

/// Factory
  factory DateTimeIntervals.fromCurrentDateTime({
    Set<DateTimeElement?> setOfCalendarItems = AllCalendarItems,
    @required DateTime? eventDateTime,
  })
```

### Properties

- years?   : approximate number of years between intervals, null indicates it was not included in the 'setOfCalendarItems'
- month?   : approxiamte number of months between intervals, null indicates it was not included in the 'setOfCalendarItems'
- days?    : number of days between intervals,  null indicates it was not included in the 'setOfCalendarItems'
- hours?   : number of hours between intervals,  null indicates it was not included in the 'setOfCalendarItems'
- minutes? : number of minutes between intervals,  null indicates it was not included in the 'setOfCalendarItems'
- seconds? : number of seconds between intervals,  null indicates it was not included in the 'setOfCalendarItems'
- direction: CalendarDirection value of .between, sinceEnd, untilEnd to indicate if doing a count up/down or locked between two DateTime objects

### Methods

- String countdownBar() : returns a string layout that shows years, months, days, hours, minutes, seconds in order, where any not requested Calendar item is ignored, and gets progressively smaller as leading values reach zero. "01-11-26 12:14:59" is 1-year, 11-months, 26-days 12:hours 14:minutes, 59:seconds.

- String formattedString

```dart
String formattedString(
      {List<String> yearPlurality = const ['yr', 'yrs'],
      List<String> monthsPlurality = const ['mo', 'mos'],
      List<String> daysPlurality = const ['dy', 'dys'],
      List<String> hoursPlurality = const ['hr', 'hrs'],
      List<String> minutesPlurality = const ['min', 'mins'],
      List<String> secondsPlurality = const ['sec', 'secs']})
```

The ?Plurality is the single/multiple suffix to append to a value.

Example:

An interval of 2years, 10months, 12days, 19hours, 1minute, 14seconds would produce "2 yr 10 mos 19 hrs 1 min 14 secs" {is a lite-version of a formatted display of the the interval}

## Special Note

Be kind to each other!
