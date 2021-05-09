part of 'location_cubit.dart';

abstract class LocationState {
  final LocationServiceState locationServiceState;
  LocationState(this.locationServiceState);
}

class GotCurrentLocation extends LocationState {
  final UserLocationData? locationData;
  GotCurrentLocation(this.locationData) : super(LocationServiceState.locationData);
}

class GotSavedLocation extends LocationState {
  final UserLocationData? locationData;
  GotSavedLocation(this.locationData) : super(LocationServiceState.locationDataRetrieved);
}

class GotUserLocationDistance extends LocationState {
  final UserLocationDistance? userLocationDistance;
  GotUserLocationDistance(this.userLocationDistance) : super(LocationServiceState.gotUserLocationDistance);
}

class LocationDataSaved extends LocationState {
  LocationDataSaved() : super(LocationServiceState.locationDataSaved);
}

class LocationInitial extends LocationState {
  LocationInitial() : super(LocationServiceState.initial);
}

class LocationServiceDenied extends LocationState {
  LocationServiceDenied() : super(LocationServiceState.denied);
}

class LocationServiceDeniendForever extends LocationState {
  LocationServiceDeniendForever() : super(LocationServiceState.deniedForever);
}

class LocationServiceDisabled extends LocationState {
  LocationServiceDisabled() : super(LocationServiceState.disabled);
}

class LocationServiceServiceEnabled extends LocationState {
  LocationServiceServiceEnabled() : super(LocationServiceState.enabled);
}

class SetupComplete extends LocationState {
  SetupComplete() : super(LocationServiceState.setupComplete);
}
