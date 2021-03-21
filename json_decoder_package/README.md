# json_decoder

Performs "safe" json decoding, and returns information about type (list, map), and decode duration.

## Getting Started

example

```dart
final String good = '[{"name":"steven","title":"grand poobah"},{"name":"steven","title":"grand poobah"}]';
    final Either<Exception, JsonDecoded> goodResult = JSONDecoder.decode(good);
    goodResult.fold(
      (l) => debugPrint('Error ${l.toString()}'),
      (r) => debugPrint('Decoded ${r.toString()}'),
    );
```

### JsonDecodeType

```dart
enum JsonDecodeType {
  list,
  map,
}
```

### JsonDecoded

```dart
  final String source;                  // Source String
  dynamic? result;                      // Decoded result, if any
  final Duration? duration              // Duration to decode json, if successful otherwise null
  final Map<String, dynamic>? jsonMap;  // Return decode string as jsonMap if possible, otherwise null
  final List<Map<String, dynamic>>? jsonList;  //Return decoded string as JsonList if possible, otherwise null
  final JsonDecodeType? jsonType;       // Decoded type else null
```

## Conclusion

Be kind to each other.
