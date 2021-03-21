// Copyright 2021 LTMM. All rights reserved.

import 'package:equatable/equatable.dart';

import '../../network_connection.dart';

abstract class ConnectionEvent extends Equatable {
  const ConnectionEvent();
  List<Object> get props => [];
}

class ConnectionChangedEvent extends ConnectionEvent {
  final NetworkConnectionType type;
  const ConnectionChangedEvent(this.type);
  @override
  List<Object> get props => [type];
}

class DataAccessEvent extends ConnectionEvent {
  final bool connected;
  const DataAccessEvent(this.connected);
  @override
  List<Object> get props => [connected];
}
