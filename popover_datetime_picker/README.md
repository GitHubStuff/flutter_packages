# popover_datetime_picker

Wrap a widget inside PopoverDateTimePicker, and it becomes a touchable widget that will display a date/time picker popover.

The date value can be set, or dismissed if touched outside the picker

## Getting Started

**defination:**

```dart
PopoverDateTimePicker({
    Key? key,
    required Widget onWidget,
    required Function(DateTime) callback,
    DateTime initalDateTime,
    bool includeSeconds = true,
  })
```

where:

- onWidget : the widget that is wrapped by PopiverDateTimePicker
- callback : function that is called with the selected DateTime value
- initialDateTime : starting date/time. {defaults to DateTime.now()}
- includeSeconds: true/false if the scrollwheel includes seconds {defaults to true}

**example:**

```dart
PopoverDateTimePicker(
              includeSeconds: false,
              onWidget: Text(
                'Date Picker',
                style: TextStyle(fontSize: 48.0),
              ),
              callback: (newDateTime) {
                debugPrint('$newDateTime');
              }),
```

## Conclusion

Be kind to each other.
