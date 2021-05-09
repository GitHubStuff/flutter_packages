// Copyright 2021
import 'package:dartz/dartz.dart';

import '../../location_package.dart';
import '../app_exceptions.dart';
import '../persisted_data/persisted_data.dart';
import '../public_constants.dart';
import 'user_location_data.dart';

/// Abstact class that any GeoLocation service {eg geolocator} must be wrapped in so
/// that implementation details are abstracted away allow for any location service to be used
abstract class LocationService {
  PersistedData _persistedData;
  bool _setupComplete = false;

  LocationService({required PersistedData persistedData}) : _persistedData = persistedData;

  Future<Either<LocationServiceState, UserLocationData?>> getCurrentLocation();

  UserLocationData? getSavedLocation({required String key}) {
    if (!_setupComplete) throw PersistedStorageNotSetup();
    return _persistedData.getLocationData(usingKey: key);
  }

  Future<LocationServiceState> getStatus();

  Future<bool> openAndroidLocationSettings();

  Future<bool> openIosLocationSettings();

  void saveLocation({required String key, required UserLocationData locationData}) {
    if (!_setupComplete) throw PersistedStorageNotSetup();
    _persistedData.setLocationData(
      locationData,
      usingKey: key,
    );
  }

  Future<bool> setup() async {
    if (_setupComplete) return true;
    await _persistedData.setup();
    _setupComplete = persistedDataSetupComplete;
    return _setupComplete;
  }

  UserLocationDistance? userLocationDistance({required UserLocationData? startLocation, required UserLocationData? endLocation});
}
