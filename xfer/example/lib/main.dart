import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart' as D;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

Map<String, String> get assetPngHeaders => {
      'Content-Type': 'image/png',
    };

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
  AssetImage? assetImage;
  String message = 'Data without context';
  Widget fetched = Text('Fetch');

  @override
  void initState() {
    super.initState();
    assetImage = AssetImage('images/theme.png');
  }

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
            Container(
              child: fetched,
              height: 100,
              width: 100,
            ),
            Container(
              child: _lookup(),
              height: 75,
              width: 75,
            ),
            Container(
              child: Image(image: assetImage!),
              height: 175,
              width: 175,
            ),
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
                D.Either<XferFailure, XferResponse> result = await Xfer().get('asset://images/brand.png', headers: assetPngHeaders);
                result.fold(
                  (l) => null,
                  (r) {
                    setState(() {
                      assetImage = r.body as AssetImage;
                    });
                    final xx = r.body as AssetImage;
                    debugPrint('$xx');
                  },
                );
                debugPrint('$result');
              },
              child: Text('PNG')),
          FloatingActionButton(
              onPressed: () async {
                final result = Xfer().post('pref://myKey', value: 11);
                debugPrint('$result');
              },
              child: Text('P')),
          FloatingActionButton(
              onPressed: () async {
                final result = Xfer().post('pref://myKey', value: 11);
                debugPrint('$result');
              },
              child: Text('C')),
          FloatingActionButton(
              onPressed: () async {
                final cacheHeader = CachedHeader(
                  placeholderAssetName: '', //'onboarding/bird.png',
                  placeholderPackage: 'xfer',
                  errorAssetName: '', //'images/brand.png',
                );
                final result = await Xfer().get('cachedImage://picsum.photos/500', headers: cacheHeader.asHeader());
                result.fold(
                  (l) {
                    setState(() {
                      fetched = Text('${l.toString()}');
                    });
                  },
                  (r) {
                    setState(() {
                      fetched = r.body as CachedNetworkImage;
                    });
                  },
                );
                debugPrint('$result');
              },
              child: Text('GP')),
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

  Widget _lookup() {
    final cacheHeader = CachedHeader(
      placeholderAssetName: '', //'onboarding/bird.png',
      placeholderPackage: 'xfer',
      errorAssetName: '', //'images/brand.png',
    );
    final idx = Random().nextInt(50) + 1000;
    final result = Xfer().fetch('cachedImage://picsum.photos/id/$idx/200', headers: cacheHeader.asHeader(), imageError: null);
    return result.fold((l) => Text('Error $l'), (r) {
      final widget = r.body as CachedNetworkImage;
      if (r.response != null) debugPrint('RESPONSE: ${r.response.toString()}');
      return widget;
    });
  }
}
