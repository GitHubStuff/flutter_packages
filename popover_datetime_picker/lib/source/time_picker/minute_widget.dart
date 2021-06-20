// Copyright 2021, LTMM LLC
import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';

import 'template_widget.dart';

class MinuteWidget extends TemplateWidget {
  MinuteWidget({
    Key? key,
    required Size size,
    double offAxis = 0.0,
  }) : super(
          key: key,
          timeElement: DateTimeElement.minute,
          size: size,
          offAxisFraction: offAxis,
        );
}
