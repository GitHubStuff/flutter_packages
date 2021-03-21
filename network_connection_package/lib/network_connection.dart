// Copyright 2021 LTMM. All rights reserved.

library network_connection_package;

export 'src/network_connection_monitor.dart';

enum NetworkConnectionType {
  Cellular,
  Internet,
  None,
  WiFi,
}
