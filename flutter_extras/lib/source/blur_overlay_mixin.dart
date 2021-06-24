import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';

mixin BlurOverlay {
  void overlayDismiss(BuildContext context) => Navigator.of(context, rootNavigator: true).pop();

  void showTextDialog(
    BuildContext context, {
    required String message,
    Color barrierColor = const Color(0x20ffffff),
    TextStyle style = const TextStyle(fontSize: 22.0),
  }) {
    showWidgetDialog(context,
        widget: AutoSizeText(
          message,
          maxLines: 1,
          style: style,
        ));
  }

  void showTextSpinner(
    BuildContext context, {
    required String message,
    Color barrierColor = const Color(0x20ffffff),
    TextStyle style = const TextStyle(fontSize: 22.0),
  }) =>
      showWidgetDialog(
        context,
        widget: SpinnerWidget.text(message, textStyle: style),
        barrierColor: barrierColor,
      );

  void showWidgetDialog(BuildContext context, {required Widget widget, Color barrierColor = const Color(0x20ffffff)}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Material(
        color: barrierColor,
        child: Center(
          child: widget,
        ),
      ),
    );
  }

  void showWidgetSpinner(BuildContext context, {required Widget widget, Color barrierColor = const Color(0x20ffffff)}) => showWidgetDialog(
        context,
        widget: SpinnerWidget(messageWidget: widget),
        barrierColor: barrierColor,
      );
}
