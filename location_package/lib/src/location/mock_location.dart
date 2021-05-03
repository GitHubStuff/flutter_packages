import 'package:dartz/dartz.dart';
import 'package:location_package/src/location/location_data.dart';

import '../../location_package.dart';
import '../public_constants.dart';
import 'location_service.dart';

class MockLocation extends LocationService {
  LocationData? locationData;
  LocationServiceStatus locationServiceStatus;

  MockLocation({required PersistedData persistedData, this.locationData, required this.locationServiceStatus}) : super(persistedData: persistedData);

  @override
  Future<Either<LocationServiceStatus, LocationData?>> getCurrentLocation() async => locationData == null ? Left(LocationServiceStatus.denied) : Right(locationData);

  @override
  Future<LocationServiceStatus> getStatus() async => locationServiceStatus;
}
