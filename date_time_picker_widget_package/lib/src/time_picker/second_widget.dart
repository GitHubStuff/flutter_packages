import 'package:date_time_package/date_time_package.dart';
import 'package:flutter/material.dart';

import '../../date_time_picker_widget_package.dart';
import 'minute_or_second_template_widget.dart';

class SecondWidget extends MinuteOrSecondTemplateWidget {
  SecondWidget(
    DateTimeCubit cubit, {
    Key? key,
    required Size size,
    double offAxis = 0.0,
    TextStyle? style,
  }) : super(
          cubit,
          key: key,
          timeElement: DateTimeElement.second,
          size: size,
          offAxisFraction: offAxis,
          textStyle: style,
        );
}
