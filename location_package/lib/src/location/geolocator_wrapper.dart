import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../location_package.dart';
import '../app_exceptions.dart';
import '../public_constants.dart';
import 'location_service.dart';

class GeolocatorWrapper extends LocationService {
  GeolocatorWrapper({required PersistedData persistedData}) : super(persistedData: persistedData);

  @override
  Future<Either<LocationServiceStatus, LocationData?>> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) return Left(LocationServiceStatus.deniedForever);
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
      LocationData result = LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
        dateTimestamp: position.timestamp ?? DateTime.now(),
      );
      return Right(result);
    } on PermissionDeniedException {
      return Left(LocationServiceStatus.denied);
    }
  }

  @override
  Future<LocationServiceStatus> getStatus() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return LocationServiceStatus.disabled;
      LocationPermission permission = await Geolocator.checkPermission();
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
