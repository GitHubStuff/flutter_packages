# persisted_cache

Two componets

1. persisted_cache : allows for the creation/management/display of persisted cached items
1. cached_widget : custom three(3) widget utility that handles cache list display, TextField, and submit button

## Getting Started

```dart

PersistedCache _persistedCache = PersistedCache(cacheId: 'biff');

Widget m = CachedWidget(
            persistedCache: _persistedCache,
            emptyCacheMessage: 'Nothing Cached',
            cachePopoverCallback: (data) {
              debugPrint('${DateTime.now()} DATA: $data');
            },
          );
```

## Final Note

Be kind to each other
