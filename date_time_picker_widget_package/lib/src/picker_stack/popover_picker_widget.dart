import 'package:date_time_picker_widget_package/src/cubit/date_time_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popover/popover.dart';
import 'package:theme_management_package/theme_management_package.dart';

import '../../date_time_picker_widget_package.dart';

typedef void DateTimeCallback(DateTime dateTime);

const double _arrowHeight = 10.0;
const Size _popoverSize = Size(280.0, 237.5);

class PopoverPickerWidget extends StatelessWidget {
  final Widget onWidget;
  final DateTime? initalDateTime;
  final DateTimeCallback callback;

  PopoverPickerWidget({
    Key? key,
    required this.onWidget,
    this.initalDateTime,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTimeCubit dateTimeCubit = DateTimeCubit(initalDateTime);
    return BlocProvider<DateTimeCubit>(
      create: (_) => dateTimeCubit,
      child: _GestureWidget(onWidget, dateTimeCubit, this.callback),
    );
  }
}

class _GestureWidget extends StatelessWidget {
  final Widget wrappedWidget;
  final DateTimeCubit dateTimeCubit;
  final DateTimeCallback callback;
  const _GestureWidget(this.wrappedWidget, this.dateTimeCubit, this.callback);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateTimeCubit, DateTimeState>(
      builder: (context, state) {
        debugPrint('Popoverpicker state: $state');
        if (state is SetDateTimeState) {
          callback(state.dateTime);
          Navigator.of(context).pop();
        }
        return GestureDetector(
          child: wrappedWidget,
          onTap: () {
            showPopover(
              context: context,
              bodyBuilder: (context) => _picker(),
              onPop: () {},
              width: _popoverSize.width,
              height: _popoverSize.height,
              arrowHeight: _arrowHeight,
              arrowWidth: 30,
            );
          },
        );
      },
    );
  }

  Widget _picker() {
    return DateTimeStack(
      brightness: Brightness.light,
      dateTimeCubit: dateTimeCubit,
      datePickerColor: CustomColor(dark: Colors.purple.shade100, light: Colors.amber.shade900),
      timePickerColor: CustomColor(dark: Colors.red.shade100, light: Colors.purple.shade400),
    );
  }
}
