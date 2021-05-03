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
  final blck = LocationCubit(locationService: GeolocatorWrapper(persistedData: HivePersistedData()));
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

  Text message(String s) {
    return Text(
      s,
      style: TextStyle(fontSize: 24.0),
    );
  }

  Widget _bloc() {
    return BlocBuilder<LocationCubit, LocationState>(
        bloc: blck,
        builder: (context, state) {
          debugPrint('🧐 STATE: $state');
          List<Widget> column = [];
          switch (state.locationServiceStatus) {
            case LocationServiceStatus.initial:
              blck.setup();
              break;
            case LocationServiceStatus.setupComplete:
              column.add(message('setup complete'));
              final button = TextButton(
                onPressed: () => blck.getCurrentLocation(),
                child: message('get location data'),
              );
              column.add(button);
              break;
            case LocationServiceStatus.denied:
              column.add(message('Permission denined'));
              break;
            case LocationServiceStatus.disabled:
              column.add(message('Location Serviced disabled'));
              break;
            case LocationServiceStatus.deniedForever:
              column.add(message('Location denied forever!!'));
              break;
            case LocationServiceStatus.locationData:
              if (state is LocationDataReturned) {
                column.add(message('${state.locationData.toString()}'));
              }
              break;
            default:
              debugPrint('☠️ ${state.locationServiceStatus} not handled');
          }
          column.add(message('Done'));
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: column,
          ));
        });
  }
}
