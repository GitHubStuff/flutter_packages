import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:location_package/location_package.dart';

class LocationWidget extends StatefulWidget {
  @override
  _LocationWidget createState() => _LocationWidget();
}

class _LocationWidget extends State<LocationWidget> {
  @override
  Widget build(BuildContext context) {
    return _scaffold();
  }

  Widget _scaffold() {
    return Scaffold(
      appBar: AppBar(title: Text('Fetch location')),
      body: Center(child: _body()),
    );
  }

  Widget _body() {
    final LocationCubit locationCubit = Modular.get<LocationCubit>();
    return BlocBuilder<LocationCubit, LocationState>(
        bloc: locationCubit,
        builder: (context, state) {
          debugPrint('🧐 STATE: $state');
          bool showGetLocation = false;
          UserLocationData locationData;
          List<Widget> column = [];
          switch (state.locationServiceStatus) {
            case LocationServiceStatus.initial:
              locationCubit.setup();
              break;
            case LocationServiceStatus.setupComplete:
              column.add(message('setup complete'));
              showGetLocation = true;
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
          if (showGetLocation) column.add(_getLocationButton(locationCubit));

          column.add(message('Done'));
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: column,
          ));
        });
  }

  Widget _getLocationButton(LocationCubit locationCubit) => TextButton(
        onPressed: () => locationCubit.getCurrentLocation(),
        child: message('get location data'),
      );

  Widget _saveLocationButton(LocationCubit locationCubit) => TextButton(
        onPressed: () => locationCubit.getCurrentLocation(),
        child: message('save location data'),
      );
  Text message(String s) {
    return Text(
      s,
      style: TextStyle(fontSize: 24.0),
    );
  }
}
