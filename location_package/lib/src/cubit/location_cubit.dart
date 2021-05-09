// Copyright 2021
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:location_package/location_package.dart';
import 'package:location_package/src/location/user_location_data.dart';
import 'package:location_package/src/widgets/location_permission_widget.dart';

import '../../src/app_exceptions.dart';
import '../../src/location/location_service.dart';
import '../../src/persisted_data/persisted_data.dart';
import '../public_constants.dart';

part 'location_state.dart';

typedef LocationDistances = double Function(UserLocationData, UserLocationData);

/// BLoC for the states/events of Location Readings, Saved Lookups, and Updates to Saved locations
class LocationCubit extends Cubit<LocationState> {
  late LocationService _locationService;
  bool _setupComplete = false;

  LocationCubit({required LocationService locationService})
      : _locationService = locationService,
        super(LocationInitial());

  void compareCurrentLocationAndSavedLocation({required String key}) async {
    UserLocationData? data = _locationService.getSavedLocation(key: key);
    if (data == null) {
      emit(GotUserLocationDistance(null));
      return;
    }
    Either<LocationServiceStatus, UserLocationData?> result = await _locationService.getCurrentLocation();
    result.fold((left) {
      emit(GotUserLocationDistance(null)); //TODO: Better error correction
    }, (right) {
      final UserLocationDistance? result = (right == null) ? null : _locationService.userLocationDistance(startLocation: data, endLocation: right);
      emit(GotUserLocationDistance(result));
    });
  }

  void getCurrentLocation() async {
    Either<LocationServiceStatus, UserLocationData?> result = await _locationService.getCurrentLocation();
    result.fold((left) {
      switch (left) {
        case LocationServiceStatus.denied:
          emit(LocationServiceDenied());
          break;
        case LocationServiceStatus.deniedForever:
          emit(LocationServiceDeniendForever());
          break;
        case LocationServiceStatus.disabled:
          emit(LocationServiceDisabled());
          break;
        default:
          throw UnknownLocationPermissionException('$left');
      }
    }, (right) {
      if (right == null) throw UnknownLocationPermissionException('Returned NULL location data');
      emit(GotCurrentLocation(right));
    });
  }

  void getSavedLocation({required String key}) {
    UserLocationData? data = _locationService.getSavedLocation(key: key);
    emit(GotCurrentLocation(data));
  }

  Widget locationSettingsWidget({
    required String title,
    required String content,
    required String openString,
    required String cancelString,
  }) {
    return LocationPermissionWidget(
      locationService: _locationService,
      title: title,
      content: content,
      openString: openString,
      cancelString: cancelString,
    );
  }

  void saveLocation(UserLocationData userLocationData, {required String key}) {
    _locationService.saveLocation(key: key, locationData: userLocationData);
    emit(LocationDataSaved());
  }

  void setup() async {
    await _locationService.setup();
    _setupComplete = persistedDataSetupComplete;
    if (!_setupComplete) throw PersistedStorageNotSetup();
    emit(SetupComplete());
  }
}
