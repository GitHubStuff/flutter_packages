import 'package:geolocator/geolocator.dart';

import 'location_data.dart';
import 'location_service_status.dart';

abstract class LocationService {
  LocationServiceStatus getStatus();
  Future<LocationData?> getCurrentLocation();
  LocationData getSavedLocation({required String key});
  void saveLocation({required String key, required LocationData locationData});
}

class GeolocatorWrapper implements LocationService {
  @override
  Future<LocationData?> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    LocationData result = LocationData(
      latitude: position.latitude,
      longitude: position.longitude,
      dateTimestamp: position.timestamp ?? DateTime.now(),
    );
    return result;
  }

  @override
  LocationData getSavedLocation({required String key}) {
    // TODO: implement getSavedLocation
    throw UnimplementedError();
  }

  @override
  LocationServiceStatus getStatus() {
    // TODO: implement getStatus
    throw UnimplementedError();
  }

  @override
  void saveLocation({required String key, required LocationData locationData}) {
    // TODO: implement saveLocation
  }
}
