import 'package:date_time_picker_widget_package/date_time_picker_widget_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

final yearWidgetSize = Size(100, 150);
final monthWidgetSize = Size(90, 150);
final dayWidgetSize = Size(80, 150);

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
  final dateTimeCubit = DateTimeCubit(DateTime(2020, 1, 31));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dateTimeCubit.changeYear(2022);
        },
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
          // building(),
          // creating(),
          Row(children: [
            YearWidget(dateTimeCubit, size: yearWidgetSize),
            MonthWidget(dateTimeCubit, size: monthWidgetSize),
            DayWidget(dateTimeCubit, size: dayWidgetSize),
          ]),
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
