import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xfer/xfer.dart';

const String progressRoot = 'https://baas.kinvey.com/appdata/kid_rk7CWpu8w/';
Map<String, String> get httpPostHeaders => {
      'Content-Type': 'application/json',
      'Authorization': 'Basic c3RldmVuLnNtaXRoOkZIQ1AyMDIwIQ==',
    };
Map<String, String> get httpGetHeaders => {
      'Content-Type': 'application/json',
      'Authorization': 'Basic c3RldmVuLnNtaXRoOkZIQ1AyMDIwIQ==',
    };
const String collectionName = 'tutorial';

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
  String message = 'Data without context';
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
              '$message',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              onPressed: () async {
                final result = Xfer().post('pref://myKey', body: 11);
                debugPrint('$result');
              },
              child: Text('P')),
              FloatingActionButton(
              onPressed: () async {
                final result = Xfer().get('pref://myKey');
                debugPrint('$result');
              },
              child: Text('G')),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                message = "Cleared";
              });
            },
            child: (Icon(Icons.clear)),
          ),
          FloatingActionButton(
            onPressed: () async {
              String output = 'Output';
              try {
                final result = await Xfer(httpGetFuture: http.get).get(progressRoot + collectionName, headers: httpGetHeaders);
                output = result.toString();
              } catch (error) {
                output = error.toString();
              }
              setState(() {
                message = output;
              });
            },
            child: Text('Get'),
          ),
          FloatingActionButton(
            onPressed: () async {
              final Map<String, String> data = {'data': '${DateTime.now().toIso8601String()}'};
              final resp = await http.post(
                Uri.parse('https://baas.kinvey.com/appdata/kid_rk7CWpu8w/tutorial'),
                headers: httpPostHeaders,
                body: jsonEncode(data),
              );
              debugPrint('${resp.toString()}');
              String output = 'Output';
              if (data.isEmpty) {
                try {
                  final result = await Xfer(httpPostFuture: http.post).post(
                    progressRoot + collectionName,
                    headers: httpPostHeaders,
                    body: jsonEncode(data),
                  );
                  output = result.toString();
                } catch (err) {
                  output = err.toString();
                }
              }
              setState(() {
                message = output;
              });
            },
            tooltip: 'Increment',
            child: Text('Post'),
          ),
        ],
      ),
    );
  }
}
