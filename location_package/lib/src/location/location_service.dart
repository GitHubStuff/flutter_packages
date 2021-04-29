import 'package:location_package/location_package.dart';

import 'location_data.dart';
import 'location_service_status.dart';

abstract class LocationService {
  LocationService({required PersistedData persistedData}) : _persistedData = persistedData;
  PersistedData _persistedData;
  Future<LocationServiceStatus> getStatus();
  Future<LocationData?> getCurrentLocation();
  LocationData? getSavedLocation({required String key}) => _persistedData.getLocationData(usingKey: key);
  void saveLocation({required String key, required LocationData locationData}) => _persistedData.setLocationData(
        locationData,
        usingKey: key,
      );
}
