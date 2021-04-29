import 'package:app_exception/app_exception.dart';

class UnknownHiveException extends AppException {
  UnknownHiveException([String message = '', int code = 16]) : super(message, 'Unhandled HIVE exception');
}

class PersistedStorageNotSetup extends AppException {
  PersistedStorageNotSetup() : super('Persisted Storage "setup" has not been called', 'Storage exception', 404);
}

class MissingLocationPermission extends AppException {
  MissingLocationPermission() : super('Application permission for location setting missing', 'Permission exception', 400);
}