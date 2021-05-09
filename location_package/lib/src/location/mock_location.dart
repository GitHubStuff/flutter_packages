// Copyright 2021
import 'package:dartz/dartz.dart';
import 'package:location_package/src/distance/user_location_distance.dart';
import 'package:location_package/src/location/location_data.dart';
import 'package:location_package/src/location/user_location_data.dart';

import '../persisted_data/persisted_data.dart';
import '../public_constants.dart';
import 'location_service.dart';

/// Class to use as mock location service for testing/development
class MockLocation extends LocationService {
  LocationData? locationData;
  LocationServiceStatus locationServiceStatus;
  UserLocationDistance? mockUserLocationDistance;

  MockLocation({
    required PersistedData persistedData,
    this.locationData,
    required this.locationServiceStatus,
    this.mockUserLocationDistance,
  }) : super(persistedData: persistedData);

  @override
  Future<Either<LocationServiceStatus, LocationData?>> getCurrentLocation() async => locationData == null ? Left(LocationServiceStatus.denied) : Right(locationData);

  @override
  Future<LocationServiceStatus> getStatus() async => locationServiceStatus;

  @override
  UserLocationDistance? userLocationDistance({
    required UserLocationData? startLocation,
    required UserLocationData? endLocation,
  }) =>
      mockUserLocationDistance;

  @override
  Future<bool> openAndroidLocationSettings() {
    // TODO: implement openAndroidLocationSettings
    throw UnimplementedError();
  }

  @override
  Future<bool> openIosLocationSettings() {
    // TODO: implement openIosLocationSettings
    throw UnimplementedError();
  }
}
