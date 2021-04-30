part of 'location_cubit.dart';

abstract class LocationState {
  final LocationServiceStatus locationServiceStatus;
  LocationState(this.locationServiceStatus);
}

class LocationInitial extends LocationState {
  LocationInitial() : super(LocationServiceStatus.initial);
}

class LocationServiceDisabled extends LocationState {
  LocationServiceDisabled() : super(LocationServiceStatus.disabled);
}

class LocationServiceDenied extends LocationState {
  LocationServiceDenied() : super(LocationServiceStatus.denied);
}

class LocationServiceDeniendForever extends LocationState {
  LocationServiceDeniendForever() : super(LocationServiceStatus.deniedForever);
}

class LocationServiceServiceEnabled extends LocationState {
  LocationServiceServiceEnabled() : super(LocationServiceStatus.enabled);
}

class SetupComplete extends LocationState {
  SetupComplete() : super(LocationServiceStatus.setupComplete);
}
