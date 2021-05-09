import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:location_package/location_package.dart';

const String LOCATION_KEY = 'location_key';

class LocationWidget extends StatefulWidget {
  @override
  _LocationWidget createState() => _LocationWidget();
}

class _LocationWidget extends State<LocationWidget> {
  UserLocationData? locationData;

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
          List<Widget> column = [];
          switch (state.locationServiceStatus) {
            case LocationServiceStatus.initial:
              locationCubit.setup();
              break;
            case LocationServiceStatus.setupComplete:
              column.add(message('setup complete'));
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
                locationData = state.locationData;
                column.add(message('Data:${state.locationData.toString()}'));
              }
              break;
            case LocationServiceStatus.locationDataRetrieved:
              if (state is LocationDataRetrived) {
                locationData = state.locationData;
                column.add(message('Saved Location:\n${state.locationData.toString()}'));
              }
              break;
            case LocationServiceStatus.locationDataSaved:
              column.add(message('Location Saved!'));
              break;
            case LocationServiceStatus.missingPermission:
            case LocationServiceStatus.enabled:
              final str = '☠️ ${state.locationServiceStatus} not handled';
              debugPrint(str);
              column.add(message(str));
          }
          column.add(_getLocationButton(locationCubit));
          column.add(_getSaveLocationButton(locationCubit));
          if (locationData != null) column.add(_saveLocationButton(locationCubit, locationData!));

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

  Widget _getSaveLocationButton(LocationCubit locationCubit) => TextButton(
        onPressed: () => locationCubit.getSavedLocation(key: LOCATION_KEY),
        child: message('get saved location'),
      );

  Widget _saveLocationButton(LocationCubit locationCubit, UserLocationData locationData) => TextButton(
        onPressed: () => locationCubit.saveLocation(locationData, key: LOCATION_KEY),
        child: message('save location'),
      );

  Text message(String s) {
    return Text(
      s,
      style: TextStyle(fontSize: 24.0),
    );
  }
}
