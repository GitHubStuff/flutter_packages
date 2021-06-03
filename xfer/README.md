# xfer

Allows for GET, POST calls with specialized protocols.

There is also 'fetch' for cached images.

## Getting Started

Supported Protocols:

- http:// https:// true network calls. [GET, POST]
- asset:// read a file from the app [GET, POST - same get]
- pref:// read/write bool, float, int, string with device preferences
- cached:// use caching to fetch

## Cached Images

To return Images from the network that cached locally, with a placeholder and/or error image, use ***CachedHeader*** class to create the headers used in the usual HTTP style of GET(String url, Map<String,String> headers)

Example:

```dart
final cacheHeader = CachedHeader(
      placeholderAssetName: 'onboarding/bird.png',
      placeholderPackage: 'xfer',
      errorAssetName: 'images/brand.png',
      errorPackage: 'xfer_app',
      width: '128',
      height: '256',
    );
```

- All the parameters are optional.
- If no placeholderAsset a circular spinner is shown
- If no errorAssetName a simple error icon is shown
- If no height/width the bounding container is used {best option}

The non-sync call is:

```dart
Either<XferFailure, XferResponse>  result = fetch(String url, {required Map<String, String> headers, Object? imageError});
```

where:

- url is prefix 'cachedImage://'+url => eg: "cachedImage://picsum.photos/200" {the url will be seperated a prefixed with 'https://'
- headers is a specialized map that can extracted from an instance of CachedHeader
- imageError is an Object? that, if included, should be of 'typedef void CachedImageError(dynamic message)', that is a callback on the error returned by the image caching process (eg 401, 404, etc)

example:

```dart
final cacheHeader = CachedHeader(
      placeholderAssetName: '', //'onboarding/bird.png',
      placeholderPackage: 'xfer',
      errorAssetName: '', //'images/brand.png',
    );
    final result = Xfer().fetch('cachedImage://picsum.photos/id/1000/200', 
                         headers: cacheHeader.asHeader(), 
                         imageError: (errorInfo) {
                                debugPrint('${errorInfo.toString()'
                        });
    return result.fold((l) => Text('Error $l'), (r) {
      final widget = r.body as CachedNetworkImage;
      if (r.response != null) debugPrint('RESPONSE: ${r.response.toString()}');
      return widget;
    });
```

## Special Note

Be kind to each other
