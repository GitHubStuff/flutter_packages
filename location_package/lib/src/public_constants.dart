// Copyright 2021, LTMM

/// Status/States returned by LocationService methods
enum LocationServiceState {
  denied,
  deniedForever,
  disabled,
  enabled,
  gotUserLocationDistance,
  initial,
  locationData,
  locationDataRetrieved,
  locationDataSaved,
  missingPermission,
  setupComplete,
}
