import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final blck = LocationCubit(locationService: GeolocatorWrapper(persistedData: HivePersistedData()));
  String status = 'Status';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _bloc(),
      floatingActionButton: FloatingActionButton(
        onPressed: goto,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  VoidCallback? goto() {
    Modular.to.pushNamed('/location');
  }

  Widget _bloc() {
    return Center(
        child: Text(
      'Push The Button',
      style: TextStyle(fontSize: 20.0),
    ));
  }
}
