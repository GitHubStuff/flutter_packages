import 'package:flutter/material.dart';

extension PlatformBrightnessExtension on BuildContext {
  Brightness get platformBrightness => MediaQuery.of(this).platformBrightness;
}
