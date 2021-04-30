import 'package:geolocator/geolocator.dart';

import '../../location_package.dart';
import '../app_exceptions.dart';
import '../public_constants.dart';
import 'location_service.dart';

class GeolocatorWrapper extends LocationService {
  GeolocatorWrapper({required PersistedData persistedData}) : super(persistedData: persistedData);

  @override
  Future<LocationData?> getCurrentLocation() async {
    LocationServiceStatus status = await getStatus();
    if (status != LocationServiceStatus.enabled) return null;
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    LocationData result = LocationData(
      latitude: position.latitude,
      longitude: position.longitude,
      dateTimestamp: position.timestamp ?? DateTime.now(),
    );
    return result;
  }

  @override
  Future<LocationServiceStatus> getStatus() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return LocationServiceStatus.disabled;
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return LocationServiceStatus.denied;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return LocationServiceStatus.deniedForever;
      }
      return LocationServiceStatus.enabled;
    } on PermissionDefinitionsNotFoundException {
      throw MissingLocationPermission();
    }
  }
}
