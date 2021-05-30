import 'package:date_time_picker_widget_package/date_time_picker_widget_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extras/flutter_extras.dart';

void main() {
  runApp(MyApp());
}

Brightness theBrightness = Brightness.dark;
String message = 'Kiss Me!';

// final w = 280.0;
// final h = 150.0;
// final yearWidgetSize = Size(w / 3.6, h);
// final monthWidgetSize = Size(w / 2.1, h);
// final dayWidgetSize = Size(w / 4.6, h);
// final timeWidgetSize = Size(w * 0.2258064516, h);
// final seperatorSize = Size(w * 0.03225806452, h);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ObservingStatefulWidget<MyHomePage> {
  final dateTimeCubit = DateTimeCubit(DateTime(2020, 12, 31, 19, 20, 23));

  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('Generic header', style: Theme.of(context).textTheme.headline3),
          _justPicker(),
          Text(
            'Text without context',
            style: Theme.of(context).textTheme.headline4,
          ),
          body(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            theBrightness = (theBrightness == Brightness.dark) ? Brightness.light : Brightness.dark;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _justPicker() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey)),
      child: PickerWidget(
        brightness: theBrightness,
        dateTimeCubit: DateTimeCubit(DateTime(2020, 2, 27, 13, 17, 19)),
      ),
    );
  }

  Widget body() {
    return Column(
      children: [
        PopoverPickerWidget(
            brightness: theBrightness,
            onWidget: Text(message, style: TextStyle(fontSize: 56.0, fontWeight: FontWeight.bold)),
            callback: (dateTime) {
              message = dateTime.toLocal().toIso8601String();
              debugPrint('Returned: $dateTime');
            }),
        // _Button(
        //   dateTimeCubit: dateTimeCubit,
        // ),
      ],
    );
  }

  Widget building() {
    return BlocBuilder<DateTimeCubit, DateTimeState>(builder: (cntx, state) {
      debugPrint('state: $state');

      return Text('Built type:${state.toString()} => ${dateTimeCubit.utcDateTime}');
    });
  }

  Widget creating() {
    return BlocBuilder<DateTimeCubit, DateTimeState>(builder: (cntx, state) {
      debugPrint('state: $state');
      return Text('Creating type:${state.toString()} => ${dateTimeCubit.utcDateTime}');
    });
  }
}
