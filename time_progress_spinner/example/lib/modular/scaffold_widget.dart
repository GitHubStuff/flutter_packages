import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:theme_manager/theme_manager.dart';
import 'package:timed_progress_spinner/timed_progress_spinner.dart';

class ScaffoldWidget extends StatefulWidget {
  ScaffoldWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ScaffoldWidget createState() => _ScaffoldWidget();
}

class _ScaffoldWidget extends ObservingStatefulWidget<ScaffoldWidget> {
  String message = 'Tap for Size';
  String instruction = 'Tap + to change the text';
  String instruction2 = 'Tap again';
  bool isFirst = true;

  int forward = 1;
  int backword = -2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          ThemeControlWidget(),
        ],
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isFirst = !isFirst;
            forward = Random().nextInt(2) + 1;
            backword = -(Random().nextInt(2) + 1);
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 100,
            width: 125,
            child: TimedProgressSpinner(
              completion: () {
                debugPrint('Forward Done');
              },
              callback: (val, dur) {
                debugPrint('forward: $val $dur');
              },
              duration: Duration(minutes: forward),
            ),
          ),
          TimedProgressSpinner(
            completion: () {
              debugPrint('Backward Done');
            },
            callback: (val, dur) {
              debugPrint('backward: $val $dur');
            },
            duration: Duration(minutes: backword),
          ),
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
    );
  }
}
