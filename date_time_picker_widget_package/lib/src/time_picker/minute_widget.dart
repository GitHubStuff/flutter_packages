import 'package:date_time_package/date_time_package.dart';
import 'package:flutter/material.dart';

import '../../date_time_picker_widget_package.dart';
import 'sixty_widget.dart';

class MinuteWidget extends SixtyWidget {
  MinuteWidget(
    DateTimeCubit cubit, {
    Key? key,
    required Size size,
    double offAxis = 0.0,
    TextStyle style = const TextStyle(fontSize: 400),
  }) : super(
          cubit,
          key: key,
          timeElement: DateTimeElement.minute,
          size: size,
          offAxisFraction: offAxis,
          textStyle: style,
        );
}
