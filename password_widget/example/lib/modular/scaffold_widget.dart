import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:siginwidget/sigin_widget.dart';
import 'package:theme_manager/theme_manager.dart';

class ScaffoldWidget extends StatefulWidget {
  ScaffoldWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ScaffoldWidget createState() => _ScaffoldWidget();
}

class _ScaffoldWidget extends ObservingStatefulWidget<ScaffoldWidget> {
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
        onPressed: () {},
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
          SignInManager(),
          // Text(AppLocalizations.of(context)!.helloWorld), //Example of localization
          // Text(
          //   message,
          // ),
          // WidgetSize(
          //   onChange: (Size size) {
          //     setState(() {
          //       final height = context.height;
          //       final width = context.width;
          //       debugPrint('height: $height, width: $width $isFirst');
          //       message = 'Size - $size';
          //     });
          //   },
          //   child: Text(
          //     isFirst ? instruction : instruction2,
          //     style: Theme.of(context).textTheme.headline4,
          //   ),
          // ),
        ],
      ),
    );
  }
}
