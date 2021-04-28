part of 'location_cubit.dart';

class LocationInitial extends LocationState {}

class LocationServiceNotEnabled extends LocationState {}

class LocationServicePermissionDenied extends LocationState {}

class LocationServicePermissionDeniendForever extends LocationState {}

class LocationServiceServiceReady extends LocationState {}


@immutable
abstract class LocationState {}
