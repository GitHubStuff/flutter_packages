// Copyright 2020 LTMM. All rights reserved.

import 'dart:async';

import 'package:connectivity/connectivity.dart';

import '../network_connection.dart';
import 'bloc/connection_bloc.dart';
import 'bloc/connection_event.dart';
import 'network_connection_check.dart';

abstract class NetworkStatus {
  final ConnectionBloc _connectionBloc;
  StreamSubscription<ConnectivityResult>? _subscription;

  NetworkStatus(ConnectionBloc connectionBloc) : _connectionBloc = connectionBloc {
    //iOS doesn't get an initial network status, so one is force polled
    connectionType().then((networkConnectionType) {
      onChange(networkConnectionType);
    });
  }

  Future<NetworkConnectionType> connectionType() async {
    final status = await (Connectivity().checkConnectivity());
    return _mapToAppNetworkStatus(status);
  }

  Future<bool> dataConnection({bool? mock}) async {
    final connection = mock ?? await NetworkConnectionCheck().hasConnection;
    return connection;
  }

  NetworkConnectionType _mapToAppNetworkStatus(ConnectivityResult status) {
    switch (status) {
      case ConnectivityResult.mobile:
        return NetworkConnectionType.Cellular;
      case ConnectivityResult.none:
        return NetworkConnectionType.None;
      case ConnectivityResult.wifi:
        return NetworkConnectionType.WiFi;
    }
  }

  void close() {
    _subscription?.cancel();
    _subscription = null;
  }

  void listen() {
    if (_subscription != null) return;
    _subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult connectivityResult) {
      final result = _mapToAppNetworkStatus(connectivityResult);
      onChange(result);
    });
  }

  void onChange(NetworkConnectionType result) {
    onConnectioned();
    _connectionBloc.add(ConnectionChangedEvent(result));
  }

  Future<void> onConnectioned() async {
    bool connected = await dataConnection();
    _connectionBloc.add(DataAccessEvent(connected));
  }
}

// MARK:
class LiveNetwork extends NetworkStatus {
  LiveNetwork({required ConnectionBloc connectionBloc}) : super(connectionBloc);
}

// MARK:
class TestNetwork extends NetworkStatus {
  NetworkConnectionType _connectivityResult;
  TestNetwork(ConnectionBloc connectionBloc, {required NetworkConnectionType connectivityResult})
      : _connectivityResult = connectivityResult,
        super(connectionBloc);

  @override
  void onChange(NetworkConnectionType connectivity, [Duration? delay = const Duration(milliseconds: 500)]) {
    Duration wait = delay ?? Duration(microseconds: 100);
    Future.delayed(wait, () {
      _connectivityResult = connectivity;
      super.onChange(connectivity);
    });
  }

  @override
  Future<NetworkConnectionType> connectionType() async => Future.delayed(Duration(milliseconds: 600), () {
        return _connectivityResult;
      });

  @override
  void listen() {}
}
