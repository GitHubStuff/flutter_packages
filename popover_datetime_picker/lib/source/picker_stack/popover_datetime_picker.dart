// Copyright 2021, LTMM LLC
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:popover/popover.dart';
import 'package:theme_manager/theme_manager.dart';

import '../../source/cubit/date_time_cubit.dart';
import '../constants.dart' as K;
import '../constants.dart';
import 'picker_widget.dart';

typedef void DateTimeCallback(DateTime dateTime);

/// Wraps the host widget in a container so the Popover package will appear by the widget.
class PopoverDateTimePicker extends StatefulWidget {
  final Widget onWidget;
  final DateTime? initalDateTime;
  final DateTimeCallback callback;
  final bool includeSeconds;

  PopoverDateTimePicker({
    Key? key,
    required this.onWidget,
    required this.callback,
    this.initalDateTime,
    this.includeSeconds = true,
  }) : super(key: key) {
    DateTimeCubit.cubit = DateTimeCubit(initalDateTime);
    DateTimePickerConstants();
  }

  @override
  _PopoverDateTimePicker createState() => _PopoverDateTimePicker();
}

class _PopoverDateTimePicker extends ObservingStatefulWidget<PopoverDateTimePicker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateTimeCubit, DateTimeState>(
      bloc: DateTimeCubit.cubit,
      builder: (context, state) {
        if (state is SetDateTimeState) {
          widget.callback(state.dateTime);
          Navigator.of(context).pop();
        }
        return GestureDetector(
          child: widget.onWidget,
          onTap: () {
            showPopover(
              backgroundColor: ThemeManager.color(K.captionColors, context: context),
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
      includeSeconds: widget.includeSeconds,
    );
  }
}
