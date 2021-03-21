import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:network_connection_package/network_connection.dart';
import 'package:network_connection_package/src/bloc/connection_bloc.dart';
import 'package:network_connection_package/src/bloc/connection_event.dart';
import 'package:network_connection_package/src/bloc/connection_state.dart';
import 'package:network_connection_package/src/network_status.dart';

class MockNetwork extends Mock implements LiveNetwork {
  MockNetwork(ConnectionBloc? bloc) : super();
}

void main() {
  MockNetwork? mockNetwork;
  ConnectionBloc? connectionBloc;

  setUp(() {
    connectionBloc = ConnectionBloc(ConnectionInitialState());
    mockNetwork = MockNetwork(connectionBloc);
  });

  tearDown(() {
    mockNetwork?.close();
  });

  test('close does not emit new states', () {
    expectLater(
      connectionBloc,
      emitsInOrder([ConnectionInitialState(), emitsDone]),
    );
    connectionBloc?.close();
  });

  test('Changed state to "wifi"', () {
    final expectedResponse = [
      ConnectionInitialState(),
      ConnectedWifiState(),
    ];
    expectLater(
      connectionBloc,
      emitsInOrder(expectedResponse),
    );

    connectionBloc?.add(ConnectionChangedEvent(NetworkConnectionType.WiFi));
  });

  test('Network reported change to "wifi"', () async {
    final expectedResponse = [
      ConnectionInitialState(),
      ConnectedWifiState(),
    ];
    expectLater(
      connectionBloc,
      emitsInOrder(expectedResponse),
    );
    if (connectionBloc != null) {}
    final network = TestNetwork(connectionBloc!, connectivityResult: NetworkConnectionType.WiFi);
    network.onChange(NetworkConnectionType.WiFi);
  });
}
