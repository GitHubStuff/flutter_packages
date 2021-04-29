import 'package:location_package/src/location/location_data.dart';
import 'package:location_package/src/location/location_service_status.dart';

import '../../location_package.dart';
import 'location_service.dart';

class MockLocation extends LocationService {
  LocationData? locationData;
  LocationServiceStatus locationServiceStatus;

  MockLocation({required PersistedData persistedData, this.locationData, required this.locationServiceStatus}) : super(persistedData: persistedData);

  @override
  Future<LocationData?> getCurrentLocation() async => locationData;

  @override
  Future<LocationServiceStatus> getStatus() async => locationServiceStatus;
}