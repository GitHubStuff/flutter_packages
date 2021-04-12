# date_time_picker_widget_package

Creates a popover-style widget that lets the user create a DateTime response.

The idea of the widget is create a simple date-time Picker Widget that appears over any widget on the current screen.

The popover is 'barrierDismissible' in that any taps outside the picker-widget will dismiss the widget without triggering the ***(DateTime dateTime){}*** callback.

## Quick Start

```dart
import 'package:date_time_picker_widget_package/date_time_picker_widget_package.dart';

....

PopoverPickerWidget(brightness: {Brightness.light or Brightness.dark},
                    onWidget: {Widget},  // The widget the popover will appear next to
                    callback: (DateTime dateTime) {
                           // Returned local dateTime rounded to the second
                    });
```

## Details

The popover widget has ***header*** that displays the date/time slaved to the picker, and ***SET*** button to accept the date/time and dismiss the picker.

Next is the segment button to pick the ***DatePicker*** or the ***TimePicker***, the button controlls which
scroll-picker is displayed.

Next is Stack with ***DatePicker*** and ***TimePicker***, only one is visibable at a time and display
is controlled by the segment button.

```dart
class PopoverPickerWidget extends StatefulWidget {
  final Widget onWidget;
  final DateTimeCallback callback;
  final Brightness brightness;
  final DateTime? initalDateTime;
  final CustomColor datePickerColor;
  final CustomColor timePickerColor;
  final CustomColor pickerColor;
  final CustomColor setButtonColors;
  final CustomColor pickerTextColors;
  final TextStyle? headerTextStyle;

```

- ^onWidget : Widget that will have popover appear by
- ^callback : calls back with the date/time selected
- ^brightness : to match the theme for light/dark themes
- initialDateTime : if null the current date/time will be used
- datePickerColor : color pair for the date-picker
- timePickerColor : color pair for the time-picker
- pickerColor : color pair for the background color of the entire widget
- setButtonColors : color pair for the "Set" button in the ***header***
- pickerTextColors : color pair for the text color in the scrolling pickers
- headerTextStyle : text style applied to the text of the date/time feedback in the ***header***

^ *required parameter (see **QUICK START**)

## Conclusion

Be kind to each other!
