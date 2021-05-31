//Copyright 2021, LTMM LLC
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_manager/theme_manager.dart';

import '../../source/cubit/date_time_cubit.dart';
import '../constants.dart' as K;

/// Widget that shows the date/time as it is updated by the pickers, and the 'Set'-button
class PickerHeaderWidget extends StatelessWidget {
  final String dateFormat;
  final String timeFormat;
  final Widget setButtonWidget;
  PickerHeaderWidget({
    Key? key,
    this.dateFormat = K.dateFormatString,
    this.timeFormat = K.timeFormatString,
    this.setButtonWidget = K.setWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTimeCubit dateTimeCubit = DateTimeCubit.cubit;
    return BlocBuilder<DateTimeCubit, DateTimeState>(
        bloc: dateTimeCubit,
        builder: (cntxt, dateTimeState) {
          final dateText = dateTimeCubit.formattedDateTime(dateFormat);
          final timeText = dateTimeCubit.formattedDateTime(timeFormat);
          return Container(
            color: ThemeManager.color(K.captionColors, context: context),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(mainAxisSize: MainAxisSize.max, children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AutoSizeText(
                        '$dateText',
                        maxFontSize: 20.0, //K.fontSize,
                        style: K.textStyle(context: context),
                        //minFontSize: K.headerFontSize,
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        '$timeText',
                        maxFontSize: 20.0, //K.fontSize,
                        style: K.textStyle(context: context),
                        //minFontSize: K.headerFontSize,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                _setButton(),
              ]),
            ),
          );
        });
  }

  Widget _setButton() {
    final DateTimeCubit dateTimeCubit = DateTimeCubit.cubit;
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6, right: 0, left: 0),
      child: ElevatedButton(
        style: _buttonStyle(),
        onPressed: () {
          dateTimeCubit.dateTimeSelected();
        },
        child: setButtonWidget,
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          return Colors.transparent; // Use the component's default.
        },
      ),
    );
  }
}
