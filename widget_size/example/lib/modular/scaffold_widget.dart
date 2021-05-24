import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:theme_management_package/theme_management_package.dart';
import 'package:widget_size/widget_size.dart';

class ScaffoldWidget extends StatefulWidget {
  ScaffoldWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ScaffoldWidget createState() => _ScaffoldWidget();
}

class _ScaffoldWidget extends State<ScaffoldWidget> {
  String message = 'Tap for Size';
  @override
  Widget build(BuildContext context) {
    final themeCubit = Modular.get<ThemeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          ThemeControlWidget(
            themeCubit: themeCubit,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              message,
            ),
            WidgetSize(
              onChange: (Size size) {
                setState(() {
                  message = 'Size - $size';
                });
              },
              child: Text(
                'Text without context',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
