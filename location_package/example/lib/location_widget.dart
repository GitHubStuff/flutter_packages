// Copyright 2021, LTMM
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

  Text message(String s) {
    return Text(
      s,
      style: TextStyle(fontSize: 24.0),
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
              column.add(message('Permission denied'));
              break;
            case LocationServiceStatus.disabled:
              column.add(message('Location Serviced disabled'));
              break;
            case LocationServiceStatus.deniedForever:
              column.add(message('Location denied forever!!'));
              break;
            case LocationServiceStatus.locationData:
              if (state is GotCurrentLocation) {
                locationData = state.locationData;
                column.add(message('Data:${state.locationData.toString()}'));
              }
              break;
            case LocationServiceStatus.locationDataRetrieved:
              if (state is GotSavedLocation) {
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
              break;
            case LocationServiceStatus.gotUserLocationDistance:
              if (state is GotUserLocationDistance) column.add(message('distance/interval:\n${state.userLocationDistance}'));
              break;
          }
          column.add(_getLocationButton(locationCubit));
          column.add(_getSaveLocationButton(locationCubit));
          column.add(_getIntervalButton(locationCubit));
          column.add(_openLocationServiceButon(locationCubit));
          if (locationData != null) column.add(_saveLocationButton(locationCubit, locationData!));

          column.add(message('Done'));
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: column,
          ));
        });
  }

  Widget _openLocationServiceButon(LocationCubit locationCubit) => TextButton(
        onPressed: () => _showDialog(locationCubit),
        child: message('Open Location Manager'),
      );

  Future<void> _showDialog(LocationCubit locationCubit) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return locationCubit.locationSettingsWidget(
            title: 'Title',
            content: 'Content',
            openString: 'open',
            cancelString: 'cancel',
          );
        });
  }

  Widget _getIntervalButton(LocationCubit locationCubit) => TextButton(
        onPressed: () => locationCubit.compareCurrentLocationAndSavedLocation(key: LOCATION_KEY),
        child: message('get locations distance/interval'),
      );

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

  Widget _scaffold() {
    return Scaffold(
      appBar: AppBar(title: Text('Fetch location')),
      body: Center(child: _body()),
    );
  }
}
