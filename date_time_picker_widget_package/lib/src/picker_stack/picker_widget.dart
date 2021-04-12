// Copyright 2021, LTMM LLC
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:observing_stateful_widget/observing_stateful_widget.dart';
import 'package:theme_management_package/theme_management_package.dart';

import '../../date_time_picker_widget_package.dart';
import '../constants/constants.dart' as K;
import 'picker_set_widget.dart';

/// NOTE: The [whole widget] except for the popover
class PickerWidget extends StatefulWidget {
  final CustomColor pickerTextColors;
  final DateTimeCubit dateTimeCubit;
  final Size size;
  final Widget dateHeaderWidget;
  final Widget timeHeaderWidget;
  late final CustomColor datePickerColor;
  late final CustomColor timePickerColor;
  late final CustomColor pickerColor;
  final CustomColor setButtonColors;
  final Brightness brightness;
  late final TextStyle? headerTextStyle;
  PickerWidget({
    Key? key,
    required this.dateTimeCubit,
    this.pickerTextColors = K.pickerTextColors,
    this.setButtonColors = K.setButtonColors,
    TextStyle? headerTextStyle,
    this.size = K.minimalPickerSize,
    CustomColor? datePickerColor,
    CustomColor? timePickerColor,
    CustomColor? pickerColor,
    this.dateHeaderWidget = const AutoSizeText(
      K.dateText,
      maxFontSize: K.fontSize,
      minFontSize: K.minimalFontSize,
      maxLines: 1,
    ),
    this.timeHeaderWidget = const AutoSizeText(
      K.timeText,
      maxFontSize: K.fontSize,
      minFontSize: K.minimalFontSize,
      maxLines: 1,
    ),
    required this.brightness,
  })   : this.datePickerColor = (datePickerColor ?? K.datePickerColors),
        this.timePickerColor = (timePickerColor ?? K.timePickerColors),
        this.pickerColor = (pickerColor ?? K.pickerColors),
        super(key: key) {
    this.headerTextStyle = (headerTextStyle ?? K.headerTextStyle(brightness));
  }

  @override
  _PickerWidget createState() => _PickerWidget();
}

class _PickerWidget extends ObservingStatefulWidget<PickerWidget> {
  double _dateOpacity = K.fullOpacity;
  double _timeOpacity = K.emptyOpacity;
  late TimePickerWidget _timePickerWidget;
  late DatePickerWidget _datePickerWidget;

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    _timePickerWidget = TimePickerWidget(
      dateTimeCubit: widget.dateTimeCubit,
      size: widget.size,
      textColor: widget.pickerTextColors.of(widget.brightness),
    );
    _datePickerWidget = DatePickerWidget(
      dateTimeCubit: widget.dateTimeCubit,
      size: widget.size,
      pickerTextColor: widget.pickerTextColors.of(widget.brightness),
    );
    return SizedBox(
      width: widget.size.width,
      child: Column(
        children: [
          SizedBox(height: widget.size.height / K.headerWidgetFactor, child: _dateTimeAndSetButton()),
          SizedBox(height: widget.size.height / K.segmentButtonFactor, child: _segmentButtonsOfDateTime()),
          SizedBox(height: widget.size.height, child: _stackOfDateAndTimeScrollWidgets()),
        ],
      ),
    );
  }

  /// Displays the date/time matching the values in the pickers, with a "set"-button
  Widget _dateTimeAndSetButton() => PickerSetWidget(
        brightness: widget.brightness,
        dateTimeCubit: widget.dateTimeCubit,
        dateTimeStyle: widget.headerTextStyle!,
        setButtonColors: widget.setButtonColors,
      );

  /// Button to control if the DatePicker or TimePicker is displayed (aka which Widget in the Stack Widget is visible)
  Widget _segmentButtonsOfDateTime() {
    return Container(
      color: K.pickerColors.of(widget.brightness),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: widget.datePickerColor.of(widget.brightness)),
              onPressed: () {
                if (_dateOpacity != K.fullOpacity) {
                  setState(() {
                    _dateOpacity = K.fullOpacity;
                    _timeOpacity = K.emptyOpacity;
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
                  if (_timeOpacity != K.fullOpacity) {
                    setState(() {
                      _dateOpacity = K.emptyOpacity;
                      _timeOpacity = K.fullOpacity;
                    });
                  }
                },
                child: widget.timeHeaderWidget),
          )
        ],
      ),
    );
  }

  /// Stack with DatePicker atop TimePicker
  Widget _stackOfDateAndTimeScrollWidgets() {
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: _dateOpacity,
          duration: K.crossFadeDuration,
          child: IgnorePointer(
            ignoring: _dateOpacity != K.fullOpacity,
            child: Container(
              color: widget.datePickerColor.of(widget.brightness),
              child: _datePickerWidget,
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: _timeOpacity,
          duration: K.crossFadeDuration,
          child: IgnorePointer(
            ignoring: _timeOpacity != K.fullOpacity,
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
