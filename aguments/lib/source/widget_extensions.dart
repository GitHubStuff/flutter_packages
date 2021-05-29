import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget removed(bool state) => state ? SizedBox(height: 1) : this;
  Widget hide(bool state) => Opacity(opacity: state ? 0.0 : 1.0, child: this);
}
