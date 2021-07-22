import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:keypad_popover/keypad_popover.dart';
import 'package:theme_manager/theme_manager.dart';

class ScaffoldWidget extends StatefulWidget {
  ScaffoldWidget({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _ScaffoldWidget createState() => _ScaffoldWidget();
}

class _ScaffoldWidget extends ObservingStatefulWidget<ScaffoldWidget> {
  final Widget holder = Text("PlaceHolder");

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
          KeypadPopover(
            onWidget: holder,
            callback: (rest) {
              debugPrint('RESULT $rest');
            },
          );
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
          holder,
          KeypadPopover(
              onWidget: Text(
                'This is the place to tap',
                style: TextStyle(fontSize: 32.0),
              ),
              callback: (rst) {
                debugPrint('Result: $rst');
              }),
        ],
      ),
    );
  }
}
