// Copyright 2021, LTMM LLC
import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';

import 'template_widget.dart';

class SecondWidget extends TemplateWidget {
  SecondWidget({
    Key? key,
    required Size size,
    double offAxis = 0.0,
  }) : super(
          key: key,
          timeElement: DateTimeElement.second,
          size: size,
          offAxisFraction: offAxis,
        );
}
