// Copyright 2021, LTMM LLC
import 'package:date_time_picker_widget_package/src/cubit/date_time_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:observing_stateful_widget/observing_stateful_widget.dart';
import 'package:popover/popover.dart';
import 'package:theme_management_package/theme_management_package.dart';

import '../../date_time_picker_widget_package.dart';
import '../constants/constants.dart' as K;

typedef void DateTimeCallback(DateTime dateTime);

/// Wraps the host widget in a container so the Popover package will appear by the widget.
class PopoverPickerWidget extends StatefulWidget {
  final Widget onWidget;
  final DateTime? initalDateTime;
  final DateTimeCallback callback;
  final Brightness brightness;
  final CustomColor datePickerColor;
  final CustomColor timePickerColor;
  final CustomColor pickerColor;
  late final TextStyle? headerTextStyle;

  PopoverPickerWidget({
    Key? key,
    required this.onWidget,
    required this.brightness,
    required this.callback,
    this.initalDateTime,
    this.datePickerColor = K.datePickerColor,
    this.timePickerColor = K.timePickerColor,
    this.pickerColor = K.pickerColor,
    TextStyle? headerTextStyle,
  }) : super(key: key) {
    this.headerTextStyle = (headerTextStyle ?? K.headerTextStyle(brightness));
  }

  @override
  _PopoverPickerWidget createState() => _PopoverPickerWidget();
}

class _PopoverPickerWidget extends ObservingStatefulWidget<PopoverPickerWidget> {
  late DateTimeCubit dateTimeCubit;

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    dateTimeCubit = DateTimeCubit(widget.initalDateTime);
    return BlocBuilder<DateTimeCubit, DateTimeState>(
      bloc: dateTimeCubit,
      builder: (context, state) {
        if (state is SetDateTimeState) {
          widget.callback(state.dateTime);
          Navigator.of(context).pop();
        }
        return GestureDetector(
          child: widget.onWidget,
          onTap: () {
            showPopover(
              backgroundColor: widget.pickerColor.of(widget.brightness),
              context: context,
              bodyBuilder: (context) => _picker(),
              onPop: () {},
              width: K.minimalPopoverSize.width,
              height: K.minimalPopoverSize.height,
              arrowHeight: K.popoverArrowHeight,
              arrowWidth: K.popoverArrowWidth,
            );
          },
        );
      },
    );
  }

  Widget _picker() {
    return PickerWidget(
      brightness: widget.brightness,
      dateTimeCubit: dateTimeCubit,
      datePickerColor: widget.datePickerColor,
      timePickerColor: widget.timePickerColor,
      headerTextStyle: widget.headerTextStyle!,
    );
  }
}
