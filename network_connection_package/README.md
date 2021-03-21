# network_connection_Package

Notifies BLoC's when changes in Network connection changes. Also can report type of connection (WiFi, Celluar, or None)

## Useage

See example program.
The key class is *ConnectionBloc* that is provided to a 'NetworkStatus'-type class (two are provided *LiveNetwork* and *TestNetwork*)

The NetworkStatus the BLoC of ConnectionBloc and any time state changes[the event] (Network status performs async listening on network connectivity from the system), it will add a ConnectionChangedEvent to the ConnectionBloc, listerns of the connection block can listen/respond to those changes.

### Example

```dart

enum NetworkConnectionType {
  Cellular,
  Internet,
  None,
  WiFi,
}

_connectionBloc = ConnectionBloc();
_liveNetwork = LiveNetwork(connectionBloc: _connectionBloc)..listen();

// Current status
_liveNetwork.connectionType().then((NetworkConnectionType value) {
      if (value.toString() != buttonText) {
        setState(() {
          buttonText = value.toString();
        });
      }
    });

// Listening
return BlocBuilder(
      bloc: _connectionBloc,
      builder: (context, state) {
        if (state is ConnectedWifiState) {
          return Center(child: Text('WIFI'));
        }
        if (state is ConnectedCelluarState) {
          return Center(child: Text('Celluar'));
        }
        return Center(child: Text('None'));
);

```

**The *..listen()* is what starts the listener**

## Conclusion

Be kind to each other.
