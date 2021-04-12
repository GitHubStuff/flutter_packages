//Copyright 2021, LTMM LLC
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_management_package/theme_management_package.dart';

import '../../date_time_picker_widget_package.dart';
import '../constants/constants.dart' as K;

/// Widget that shows the date/time as it is updated by the pickers, and the 'Set'-button
class PickerSetWidget extends StatelessWidget {
  final DateTimeCubit dateTimeCubit;
  final CustomColor backgroundColors;
  final CustomColor setButtonColors;
  final Brightness brightness;
  final String dateFormat;
  final String timeFormat;
  final Widget setButtonWidget;
  final TextStyle dateTimeStyle;
  const PickerSetWidget({
    required this.dateTimeCubit,
    required this.brightness,
    this.setButtonColors = K.setButtonColors,
    this.dateFormat = K.dateFormatString,
    this.timeFormat = K.timeFormatString,
    this.backgroundColors = K.pickerColors,
    this.setButtonWidget = K.setWidget,
    required this.dateTimeStyle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateTimeCubit, DateTimeState>(
        bloc: dateTimeCubit,
        builder: (cntxt, dateTimeState) {
          final dateText = dateTimeCubit.formattedDateTime(dateFormat);
          final timeText = dateTimeCubit.formattedDateTime(timeFormat);
          return Container(
            color: backgroundColors.of(brightness),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(mainAxisSize: MainAxisSize.max, children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AutoSizeText(
                        '$dateText',
                        maxFontSize: K.fontSize,
                        style: dateTimeStyle,
                        minFontSize: K.headerFontSize,
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        '$timeText',
                        maxFontSize: K.fontSize,
                        style: dateTimeStyle,
                        minFontSize: K.headerFontSize,
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
          //if (states.contains(MaterialState.pressed)) return Colors.green;
          return setButtonColors.of(brightness); // Use the component's default.
        },
      ),
    );
  }
}
