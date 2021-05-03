import 'package:dartz/dartz.dart';
import 'package:location_package/location_package.dart';

import '../public_constants.dart';
import 'location_data.dart';

abstract class LocationService {
  PersistedData _persistedData;
  bool _setupComplete = false;
  LocationService({required PersistedData persistedData}) : _persistedData = persistedData;
  Future<LocationServiceStatus> getStatus();
  Future<Either<LocationServiceStatus, LocationData?>> getCurrentLocation();
  LocationData? getSavedLocation({required String key}) {
    if (!_setupComplete) throw PersistedStorageNotSetup();
    _persistedData.getLocationData(usingKey: key);
  }

  void saveLocation({required String key, required LocationData locationData}) {
    if (!_setupComplete) throw PersistedStorageNotSetup();
    _persistedData.setLocationData(
      locationData,
      usingKey: key,
    );
  }

  Future<bool> setup() async {
    await _persistedData.setup();
    _setupComplete = persistedDataSetupComplete;
    return _setupComplete;
  }
}
