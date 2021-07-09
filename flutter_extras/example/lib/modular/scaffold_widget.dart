import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:theme_manager/theme_manager.dart';

class ScaffoldWidget extends StatefulWidget {
  ScaffoldWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ScaffoldWidget createState() => _ScaffoldWidget();
}

class _ScaffoldWidget extends ObservingStatefulWidget<ScaffoldWidget> with BlurOverlay {
  String message = 'Tap for Size';
  String instruction = 'Tap + to change the text';
  String instruction2 = 'Tap again';
  bool isFirst = true;
  bool slide = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          ThemeControlWidget(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SlideSwitch(
              key: UniqueKey(),
              activeText: 'DBox',
              onChanged: (bool value) {
                debugPrint('VALUE! $value');
                Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    slide = false;
                  });
                });
              },
              value: slide,
            ),
            SpinnerWidget.text('Spinning!'),
            Text(
              message,
            ),
            WidgetSize(
              onChange: (Size size) {
                setState(() {
                  final height = context.height;
                  final width = context.width;
                  debugPrint('height: $height, width: $width $isFirst');
                  message = 'Size - $size';
                });
              },
              child: Text(
                isFirst ? instruction : instruction2,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            setState(() {
              slide = false;
            });
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
