part of 'location_cubit.dart';

abstract class LocationState {
  final LocationServiceStatus locationServiceStatus;
  LocationState(this.locationServiceStatus);
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

class LocationDataReturned extends LocationState {
  final UserLocationData? locationData;
  LocationDataReturned(this.locationData) : super(LocationServiceStatus.locationData);
}

class LocationDataRetrived extends LocationState {
  final UserLocationData? locationData;
  LocationDataRetrived(this.locationData) : super(LocationServiceStatus.locationDataRetrieved);
}

class LocationDataSaved extends LocationState {
  LocationDataSaved() : super(LocationServiceStatus.locationDataSaved);
}
