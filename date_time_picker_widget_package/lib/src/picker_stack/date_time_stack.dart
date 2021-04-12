import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:observing_stateful_widget/observing_stateful_widget.dart';
import 'package:theme_management_package/theme_management_package.dart';

import '../../date_time_picker_widget_package.dart';
import '../../src/picker_stack/picker_set_widget.dart';

class DateTimeStack extends StatefulWidget {
  final Size size;
  final DateTimeCubit dateTimeCubit;
  final Widget dateHeaderWidget;
  final Widget timeHeaderWidget;
  late final CustomColor datePickerColor;
  late final CustomColor timePickerColor;
  final Brightness brightness;
  DateTimeStack({
    Key? key,
    this.size = const Size(280, 150),
    required this.dateTimeCubit,
    CustomColor? datePickerColor,
    CustomColor? timePickerColor,
    this.dateHeaderWidget = const AutoSizeText(
      'Date',
      maxFontSize: 400,
      minFontSize: 22.0,
      maxLines: 1,
    ),
    this.timeHeaderWidget = const AutoSizeText(
      'Time',
      maxFontSize: 400,
      minFontSize: 22.0,
      maxLines: 1,
    ),
    required this.brightness,
  })   : this.datePickerColor = (datePickerColor ?? CustomColor(dark: Colors.green.shade900, light: Colors.white)),
        this.timePickerColor = (timePickerColor ?? CustomColor(dark: Colors.green.shade700, light: Colors.white70)),
        super(key: key);

  @override
  _DateTimeStack createState() => _DateTimeStack();
}

class _DateTimeStack extends ObservingStatefulWidget<DateTimeStack> {
  double _dateOpacity = 1.0;
  double _timeOpacity = 0.0;
  late final TimePickerWidget _timePickerWidget;
  late final DatePickerWidget _datePickerWidget;

  final _duration = Duration(milliseconds: 400);

  @override
  void initState() {
    super.initState();
    _timePickerWidget = TimePickerWidget(dateTimeCubit: widget.dateTimeCubit, size: widget.size);
    _datePickerWidget = DatePickerWidget(dateTimeCubit: widget.dateTimeCubit, size: widget.size);
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      child: Column(
        children: [
          SizedBox(height: widget.size.height / 3, child: _dateTimeAndSetButton()),
          SizedBox(height: widget.size.height / 4.0, child: _dateTimeHeaderButtons()),
          SizedBox(height: widget.size.height, child: _stackOfDateAndTimeScrollWidgets()),
        ],
      ),
    );
  }

  /// Displays the date/time matching the values in the pickers, with a "set"-button
  Widget _dateTimeAndSetButton() => PickerSetWidget(dateTimeCubit: widget.dateTimeCubit, brightness: widget.brightness);

  /// Button to control if the DatePicker or TimePicker is displayed (aka which Widget in the Stack Widget is visible)
  Widget _dateTimeHeaderButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: widget.datePickerColor.of(widget.brightness)),
            onPressed: () {
              if (_dateOpacity != 1.0) {
                setState(() {
                  _dateOpacity = 1.0;
                  _timeOpacity = 0.0;
                });
              }
            },
            child: widget.dateHeaderWidget,
          ),
        ),
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: widget.timePickerColor.of(widget.brightness)),
              onPressed: () {
                if (_timeOpacity != 1.0) {
                  setState(() {
                    _dateOpacity = 0.0;
                    _timeOpacity = 1.0;
                  });
                }
              },
              child: widget.timeHeaderWidget),
        )
      ],
    );
  }

  /// Stack with DatePicker atop TimePicker
  Widget _stackOfDateAndTimeScrollWidgets() {
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: _dateOpacity,
          duration: _duration,
          child: IgnorePointer(
            ignoring: _dateOpacity != 1.0,
            child: Container(
              color: widget.datePickerColor.of(widget.brightness),
              child: _datePickerWidget,
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: _timeOpacity,
          duration: _duration,
          child: IgnorePointer(
            ignoring: _timeOpacity != 1.0,
            child: Container(
              color: widget.timePickerColor.of(widget.brightness),
              child: _timePickerWidget,
            ),
          ),
        ),
      ],
    );
  }
}
