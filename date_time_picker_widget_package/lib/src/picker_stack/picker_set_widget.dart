import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_management_package/theme_management_package.dart';

import '../../date_time_picker_widget_package.dart';

class PickerSetWidget extends StatelessWidget {
  final Size size;
  final DateTimeCubit dateTimeCubit;
  final CustomColor backgroundColors;
  final Brightness brightness;
  final String dateFormat;
  final String timeFormat;
  const PickerSetWidget({
    required this.size,
    required this.dateTimeCubit,
    required this.brightness,
    this.dateFormat = 'EEE, MMM d, yyyy',
    this.timeFormat = 'h:mm:ss a',
    this.backgroundColors = const CustomColor(light: Colors.black12, dark: Colors.white12),
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateTimeCubit, DateTimeState>(
        bloc: dateTimeCubit,
        builder: (cntxt, dateTimeState) {
          final dateText = dateTimeCubit.dateTime(formatted: dateFormat);
          final timeText = dateTimeCubit.dateTime(formatted: timeFormat);
          return SizedBox(
            child: Container(
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
                          maxFontSize: 400,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          minFontSize: 18.0,
                          maxLines: 1,
                        ),
                        AutoSizeText(
                          '$timeText',
                          maxFontSize: 400,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          minFontSize: 18.0,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 6, right: 0, left: 0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: AutoSizeText('SET'),
                    ),
                  ),
                ]),
              ),
              color: backgroundColors.of(brightness),
            ),
            height: size.height / 3.0,
            width: size.width,
          );
        });
  }
}
