import 'package:bloc/bloc.dart';

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
}
