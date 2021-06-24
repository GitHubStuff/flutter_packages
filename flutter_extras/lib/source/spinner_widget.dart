import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SpinnerWidget extends StatelessWidget {
  final Widget messageWidget;
  final Key? widgetKey;
  final PlatformBuilder<MaterialProgressIndicatorData>? material;
  final PlatformBuilder<CupertinoProgressIndicatorData>? cupertino;

  const SpinnerWidget({
    required this.messageWidget,
    this.widgetKey,
    this.material,
    this.cupertino,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PlatformCircularProgressIndicator(
          key: UniqueKey(),
          widgetKey: widgetKey,
          material: material,
          cupertino: cupertino,
        ),
        SizedBox(width: 16),
        messageWidget
      ],
    ));
  }

  factory SpinnerWidget.text(String text, {TextStyle textStyle = const TextStyle(fontSize: 22.0)}) {
    return SpinnerWidget(
        messageWidget: PlatformText(
      text,
      style: textStyle,
      key: UniqueKey(),
    ));
  }
}
