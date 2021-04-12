import 'package:date_time_picker_widget_package/date_time_picker_widget_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_management_package/theme_management_package.dart';

void main() {
  runApp(MyApp());
}

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

class _MyHomePageState extends State<MyHomePage> {
  final dateTimeCubit = DateTimeCubit(DateTime(2020, 12, 31, 19, 20, 23));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            'Generic header',
          ),
          Text(
            'Text without context',
            style: Theme.of(context).textTheme.headline4,
          ),
          body(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget body() {
    return BlocProvider<DateTimeCubit>(
      create: (_) => dateTimeCubit,
      child: Column(
        children: [
          _Button(
            dateTimeCubit: dateTimeCubit,
          ),
        ],
      ),
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

class _Button extends StatelessWidget {
  final DateTimeCubit dateTimeCubit;
  const _Button({Key? key, required this.dateTimeCubit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopoverPickerWidget(
        onWidget: Text('PRESS ME!', style: TextStyle(fontSize: 56.0)),
        callback: (dateTime) {
          debugPrint('Returned: $dateTime');
        });
  }

  Widget _picker() {
    return DateTimeStack(
      size: Size(280, 150),
      brightness: Brightness.light,
      dateTimeCubit: dateTimeCubit,
      datePickerColor: CustomColor(dark: Colors.purple.shade100, light: Colors.amber.shade900),
      timePickerColor: CustomColor(dark: Colors.red.shade100, light: Colors.purple.shade400),
    );
  }
}

class _ListItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Zippy',
      style: TextStyle(fontSize: 56.0, color: Colors.purple),
    );
    return Scrollbar(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Text(
            'BURRPY',
            style: TextStyle(fontSize: 56.0, color: Colors.purple),
          )
        ],
      ),
    ));
  }
}
