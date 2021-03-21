// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:equatable/equatable.dart';

abstract class ConnectionState extends Equatable {
  const ConnectionState();
  List<Object> get props => [];
}

class ConnectedCelluarState extends ConnectionState {
  const ConnectedCelluarState();
}

class ConnectionInitialState extends ConnectionState {
  const ConnectionInitialState();
}

class ConnectedWifiState extends ConnectionState {
  const ConnectedWifiState();
}

class DataAccessState extends ConnectionState {
  final bool connected;
  const DataAccessState(this.connected);
  @override
  List<Object> get props => [connected];
}

class NoConnectionState extends ConnectionState {
  const NoConnectionState();
}
