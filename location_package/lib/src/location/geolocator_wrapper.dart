// Copyright 2021
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../location_package.dart';
import '../app_exceptions.dart';
import '../persisted_data/persisted_data.dart';
import '../public_constants.dart';
import 'location_data.dart';
import 'location_service.dart';
import 'user_location_data.dart';

/// This wraps the geolocator package (https://pub.dev/packages/geolocator) so that any Geolocator can be
/// swapped in, this is because any wrapper must conform to 'LocationService'-class that wraps implementation
/// details.
class GeolocatorWrapper extends LocationService {
  GeolocatorWrapper({required PersistedData persistedData}) : super(persistedData: persistedData);

  @override
  Future<Either<LocationServiceState, UserLocationData?>> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) return Left(LocationServiceState.deniedForever);
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
      UserLocationData result = LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
        dateTimestamp: position.timestamp ?? DateTime.now(),
      );
      return Right(result);
    } on PermissionDeniedException {
      return Left(LocationServiceState.denied);
    }
  }

  @override
  Future<LocationServiceState> getStatus() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return LocationServiceState.disabled;
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return LocationServiceState.denied;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return LocationServiceState.deniedForever;
      }
      return LocationServiceState.enabled;
    } on PermissionDefinitionsNotFoundException {
      throw MissingLocationPermission();
    }
  }

  @override
  Future<bool> openAndroidLocationSettings() async => await Geolocator.openAppSettings();

  @override
  Future<bool> openIosLocationSettings() async => await Geolocator.openLocationSettings();

  @override
  UserLocationDistance? userLocationDistance({required UserLocationData? startLocation, required UserLocationData? endLocation}) {
    if (startLocation == null || endLocation == null) return null;
    final distance = Geolocator.distanceBetween(
      startLocation.latitude,
      startLocation.longitude,
      endLocation.latitude,
      endLocation.longitude,
    );
    final interval = endLocation.dateTimestamp.difference(startLocation.dateTimestamp);
    return UserLocationDistance(distanceInMeters: distance, interval: interval);
  }
}
