import 'package:app_exception/app_exception.dart';
import 'package:flutter/material.dart';
import 'package:json_decoder/json_decoder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Json Decoder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Json Decoder Demo'),
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
              'Tap + and console show decoded json',
            ),
            Text(
              'Text without context',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _decodePatch('[{"name":"steven","title":"grand poobah"},{"name":"kevin","title":"guitar player"}]'),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _decodePatch(String jsonString) {
    final result = JSONDecoder.decode<AppException>(jsonString, trace: true);
    result.fold(
      (err) => debugPrint('${err.toString()}'),
      (data) {
        debugPrint('${data.toString()}');
      },
    );
  }
}
