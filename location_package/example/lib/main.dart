import 'dart:math';

import 'package:flutter/material.dart';
import 'package:location_package/location_package.dart';

const String key = 'LocData';
late PersistedData hiveData;
var random = Random();
late LocationData locationData;
late GeolocatorWrapper geolocatorWrapper;

void main() async {
  hiveData = HivePersistedData();
  await hiveData.setup();
  geolocatorWrapper = GeolocatorWrapper(persistedData: hiveData);
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
  String message = 'Result';
  String status = 'Status';
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
              'Set a Location',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(
                onPressed: _putLocationTest,
                child: Text(
                  'Press Me',
                  style: Theme.of(context).textTheme.headline5,
                )),
            Text(
              'GET Location',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(
                onPressed: _getLocationTest,
                child: Text(
                  'Press Me',
                  style: Theme.of(context).textTheme.headline5,
                )),
            Text(message, style: Theme.of(context).textTheme.headline6),
            TextButton(
              onPressed: _locationStatus,
              child: Text('Location Status', style: Theme.of(context).textTheme.headline5),
            ),
            Text(status, style: Theme.of(context).textTheme.headline6),
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

  _locationStatus() async {
    try {
      final stat = await geolocatorWrapper.getStatus();
      if (stat == LocationServiceStatus.enabled) {
        LocationData? location = await geolocatorWrapper.getCurrentLocation();
        setState(() {
          status = '$location';
        });
      } else {
        setState(() {
          status = '$stat';
        });
      }
    } on MissingLocationPermission {
      setState(() {
        status = 'MissingLocationPermission!';
      });
    }
  }

  _putLocationTest() {
    double lat = _doubleInRange(random, 50, 100);
    double lng = _doubleInRange(random, 10, 80) * -1.0;
    locationData = LocationData(latitude: lat, longitude: lng, dateTimestamp: DateTime.now());
    hiveData.setLocationData(locationData, usingKey: key);
    setState(() {
      message = 'PUT ${locationData.toString()}';
    });
  }

  _getLocationTest() {
    final result = hiveData.getLocationData(usingKey: key);
    setState(() {
      message = 'L${locationData.toString()}\nR${result.toString()}';
    });
  }

  double _doubleInRange(Random source, num start, num end) => source.nextDouble() * (end - start) + start;
}
