import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_package/location_package.dart';

void main() async {
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
      body: _bloc(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _bloc() {
    final blck = LocationCubit(locationService: GeolocatorWrapper(persistedData: HivePersistedData()));
    return BlocBuilder<LocationCubit, LocationState>(
        bloc: blck,
        builder: (context, state) {
          debugPrint('🧐 STATE: $state');
          switch (state.locationServiceStatus) {
            case LocationServiceStatus.initial:
              blck.setup();
              break;
            case LocationServiceStatus.setupComplete:
              break;
            default:
              debugPrint('☠️ ${state.locationServiceStatus} not handled');
          }
          return Center(child: Text('HERE'));
        });
  }
}
