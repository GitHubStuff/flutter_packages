part of 'location_cubit.dart';

abstract class LocationState {
  final LocationServiceStatus locationServiceStatus;
  LocationState(this.locationServiceStatus);
}

class GotCurrentLocation extends LocationState {
  final UserLocationData? locationData;
  GotCurrentLocation(this.locationData) : super(LocationServiceStatus.locationData);
}

class GotSavedLocation extends LocationState {
  final UserLocationData? locationData;
  GotSavedLocation(this.locationData) : super(LocationServiceStatus.locationDataRetrieved);
}

class GotUserLocationDistance extends LocationState {
  final UserLocationDistance? userLocationDistance;
  GotUserLocationDistance(this.userLocationDistance) : super(LocationServiceStatus.gotUserLocationDistance);
}

class LocationDataSaved extends LocationState {
  LocationDataSaved() : super(LocationServiceStatus.locationDataSaved);
}

class LocationInitial extends LocationState {
  LocationInitial() : super(LocationServiceStatus.initial);
}

class LocationServiceDenied extends LocationState {
  LocationServiceDenied() : super(LocationServiceStatus.denied);
}

class LocationServiceDeniendForever extends LocationState {
  LocationServiceDeniendForever() : super(LocationServiceStatus.deniedForever);
}

class LocationServiceDisabled extends LocationState {
  LocationServiceDisabled() : super(LocationServiceStatus.disabled);
}

class LocationServiceServiceEnabled extends LocationState {
  LocationServiceServiceEnabled() : super(LocationServiceStatus.enabled);
}

class SetupComplete extends LocationState {
  SetupComplete() : super(LocationServiceStatus.setupComplete);
}
