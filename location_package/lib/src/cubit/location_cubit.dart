import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import '../../location_package.dart';
import '../../src/location/location_service.dart';
import '../public_constants.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  late LocationService _locationService;
  bool _setupComplete = false;

  LocationCubit({required LocationService locationService})
      : _locationService = locationService,
        super(LocationInitial());

  void setup() async {
    await _locationService.setup();
    _setupComplete = persistedDataSetupComplete;
    if (!_setupComplete) throw PersistedStorageNotSetup();
    emit(SetupComplete());
  }

  void getCurrentLocation() async {
    Either<LocationServiceStatus, LocationData?> result = await _locationService.getCurrentLocation();
    result.fold((left) {
      switch (left) {
        case LocationServiceStatus.denied:
          emit(LocationServiceDenied());
          break;
        case LocationServiceStatus.deniedForever:
          emit(LocationServiceDeniendForever());
          break;
        case LocationServiceStatus.disabled:
          emit(LocationServiceDisabled());
          break;
        default:
          throw UnknownLocationPermissionException('$left');
      }
    }, (right) {
      if (right == null) throw UnknownLocationPermissionException('Returned NULL location data');
      emit(LocationDataReturned(right));
    });
  }
}
