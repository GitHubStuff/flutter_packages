// Copyright 2021, LTMM LLC
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:theme_manager/theme_manager.dart';

import '../constants.dart' as K;
import '../date_picker/date_scrolling_widget.dart';
import '../time_picker/time_scrolling_widget.dart';
import 'picker_header_widget.dart';

/// NOTE: The [entire widget] except for the popover
class PickerWidget extends StatefulWidget {
  final Size size;
  final Widget dateHeaderWidget;
  final Widget timeHeaderWidget;
  PickerWidget({
    Key? key,
    this.size = K.minimalPickerSize,
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
  }) : super(key: key);

  @override
  _PickerWidget createState() => _PickerWidget();
}

class _PickerWidget extends ObservingStatefulWidget<PickerWidget> {
  double _dateOpacity = K.fullOpacity;
  double _timeOpacity = K.emptyOpacity;
  late TimeScrollingWidget _timePickerWidget;
  late DateScrollingWidget _datePickerWidget;

  @override
  initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    _timePickerWidget = TimeScrollingWidget(size: widget.size);
    _datePickerWidget = DateScrollingWidget(size: widget.size);
    final captionHeight = widget.size.height / K.headerWidgetFactor;
    final toggleButtonHeight = widget.size.height / K.segmentButtonFactor;
    return SizedBox(
      width: widget.size.width,
      child: Stack(
        children: [
          SizedBox(height: captionHeight, child: _dateTimeAndSetButton()),
          Padding(
            padding: EdgeInsets.only(top: captionHeight + 2),
            child: SizedBox(height: widget.size.height / K.segmentButtonFactor, child: _segmentButtonsOfDateTime()),
          ),
          Padding(
            padding: EdgeInsets.only(top: captionHeight + toggleButtonHeight),
            child: SizedBox(height: widget.size.height, child: _stackOfDateAndTimeScrollWidgets()),
          ),
        ],
      ),
    );
  }

  /// Displays the date/time matching the values in the pickers, with a "set"-button
  Widget _dateTimeAndSetButton() => PickerHeaderWidget();

  /// Button to control if the DatePicker or TimePicker is displayed (aka which Widget in the Stack Widget is visible)
  Widget _segmentButtonsOfDateTime() {
    return Container(
      color: ThemeManager.color(K.captionColors, context: context),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: double.maxFinite,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ThemeManager.color(K.dateColors, context: context),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                ),
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
          ),
          Expanded(
            child: Container(
              height: double.maxFinite,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ThemeManager.color(K.timeColors, context: context),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  ),
                  onPressed: () {
                    if (_timeOpacity != K.fullOpacity) {
                      setState(() {
                        _dateOpacity = K.emptyOpacity;
                        _timeOpacity = K.fullOpacity;
                      });
                    }
                  },
                  child: widget.timeHeaderWidget),
            ),
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
              color: ThemeManager.color(K.dateColors, context: context),
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
              color: ThemeManager.color(K.timeColors, context: context),
              child: _timePickerWidget,
            ),
          ),
        ),
      ],
    );
  }
}
