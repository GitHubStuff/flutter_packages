# json_decoder

Performs "safe" json decoding, and returns information about type (list, map), and decode duration.

## Getting Started

example

```dart
final String good = '[{"name":"steven","title":"grand poobah"},{"name":"kevin","title":"guitar player"}]';
    final Either<Exception, JsonDecoded> goodResult = JSONDecoder.decode(good, reportDecodingTime = false);
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
  final Map<String, dynamic>? jsonMap;  // Return decode string as jsonMap if possible, otherwise null
  final List<Map<String, dynamic>>? jsonList;  //Return decoded string as JsonList if possible, otherwise null
  final JsonDecodeType? jsonType;       // Decoded type else null
```

## Special Note

Be kind to each other.
