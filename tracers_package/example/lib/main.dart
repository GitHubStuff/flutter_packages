import 'package:flutter/material.dart';
import 'package:tracers_package/tracers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Log.setTrace(baseLevel: LogLevel.All);
    Log.V('Starting');
    Log.A('As A');
    Log.C('As C');
    Log.D('As D');
    Log.E('As E');
    Log.F('As F');
    Log.I('As I');
    Log.M('As M');
    Log.T('As T');
    Log.V('As V');
    Log.W('As W');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'tracers_package'),
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
              'Press the button to see a time marker in the console',
            ),
            Text(
              'Text without context',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final tm = TimeMarker();
          Future.delayed(Duration(seconds: 2), () {
            tm.show();
            TimeMarker.status ? TimeMarker.disabled : TimeMarker.enabled;
          });
        },
        tooltip: 'Marker',
        child: Icon(Icons.lock_clock_sharp),
      ),
    );
  }
}
