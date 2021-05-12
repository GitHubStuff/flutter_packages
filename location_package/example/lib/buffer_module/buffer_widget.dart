import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BufferWidget extends StatefulWidget {
  BufferWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _BufferWidget createState() => _BufferWidget();
}

class _BufferWidget extends State<BufferWidget> {
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
        onPressed: null,
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
      'Do NOT Push The Button',
      style: TextStyle(fontSize: 20.0),
    ));
  }
}
