import 'package:date_time_picker_widget_package/date_time_picker_widget_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

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
  final dateTimeCubit = DateTimeCubit(DateTime.utc(2020, 2, 29));

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
          building(),
          creating(),
        ],
      ),
    );
  }

  Widget building() {
    return BlocBuilder<DateTimeCubit, DateTimeState>(builder: (cntx, state) {
      debugPrint('state: $state');
      switch (state.type) {
        case DateTimeStateType.ChangeDayState:
        case DateTimeStateType.ChangeYearState:
        case DateTimeStateType.DateTimeInitial:
      }
      return Text('Built type:${state.type} => ${dateTimeCubit.utcDateTime}');
    });
  }

  Widget creating() {
    return BlocBuilder<DateTimeCubit, DateTimeState>(builder: (cntx, state) {
      debugPrint('state: $state');
      switch (state.type) {
        case DateTimeStateType.ChangeDayState:
          return Text('Changed Day');
        case DateTimeStateType.ChangeYearState:
        case DateTimeStateType.DateTimeInitial:
      }
      return Text('Creating type:${state.type} => ${dateTimeCubit.utcDateTime}');
    });
  }
}
