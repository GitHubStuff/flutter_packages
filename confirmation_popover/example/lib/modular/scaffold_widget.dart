import 'package:confirmation_popover/conformation_popover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:theme_manager/theme_manager.dart';

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
          SizedBox(height: 20),
          ConfirmationPopover(
            Text('Hosting the popover?', style: TextStyle(fontSize: 28)),
            confirmCallback: () {
              debugPrint('Changed');
            },
            cancelCallback: () {
              debugPrint('🙀 Canceled');
            },
            leadingWidget: Icon(Icons.access_alarm_rounded),
            trailingWidget: Icon(Icons.calendar_today_outlined),
          ),
          Spacer(),
          ConfirmationPopover(
              Text(
                'Got 3 choices',
                style: TextStyle(fontSize: 28),
              ), confirmCallback: () {
            debugPrint('👍🏼 change');
          }, secondButtonCallBack: () {
            debugPrint('Door #3');
          }),
          Spacer(),
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
          Spacer(),
        ],
      ),
    );
  }
}
