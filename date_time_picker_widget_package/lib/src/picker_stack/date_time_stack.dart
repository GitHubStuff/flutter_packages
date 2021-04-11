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
  late final double _subheight;

  final _duration = Duration(milliseconds: 400);

  @override
  void initState() {
    super.initState();
    _timePickerWidget = TimePickerWidget(dateTimeCubit: widget.dateTimeCubit, size: widget.size);
    _datePickerWidget = DatePickerWidget(dateTimeCubit: widget.dateTimeCubit, size: widget.size);
    _subheight = widget.size.height / 4.0;
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return _pickerWidgetColums();
  }

  Widget _pickerWidgetColums() {
    return Column(
      children: [
        PickerSetWidget(
          size: widget.size,
          dateTimeCubit: widget.dateTimeCubit,
          brightness: widget.brightness,
        ),
        _buttons(),
        _stack(),
      ],
    );
  }

  Widget _buttons() {
    return SizedBox(
      height: _subheight,
      width: widget.size.width,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (_dateOpacity != 1.0) {
                  setState(() {
                    HapticFeedback.selectionClick();
                    _dateOpacity = 1.0;
                    _timeOpacity = 0.0;
                  });
                }
              },
              child: Container(
                color: widget.datePickerColor.of(widget.brightness),
                child: Center(child: widget.dateHeaderWidget),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (_timeOpacity != 1.0) {
                  setState(() {
                    HapticFeedback.selectionClick();
                    _dateOpacity = 0.0;
                    _timeOpacity = 1.0;
                  });
                }
              },
              child: Container(
                color: widget.timePickerColor.of(widget.brightness),
                child: Center(child: widget.timeHeaderWidget),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _stack() {
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: Stack(
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
      ),
    );
  }
}
