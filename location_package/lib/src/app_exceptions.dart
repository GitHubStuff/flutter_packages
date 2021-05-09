import 'package:app_exception/app_exception.dart';

class MissingLocationPermission extends AppException {
  MissingLocationPermission() : super('Application permission for location setting missing', 'Permission exception', 400);
}

class PersistedStorageNotSetup extends AppException {
  PersistedStorageNotSetup() : super('Persisted Storage "setup" has not been called', 'Storage exception', 404);
}

class UnknownHiveException extends AppException {
  UnknownHiveException([String message = '', int code = 16]) : super(message, 'Unhandled HIVE exception', code);
}

class UnknownLocationPermissionException extends AppException {
  UnknownLocationPermissionException([String message = '']) : super(message, 'Unknown Location Permission', 605);
}

class UnsupportedPlatform extends AppException {
  UnsupportedPlatform({required String platform}) : super(platform, 'Unsupportd Platform', 909);
}
