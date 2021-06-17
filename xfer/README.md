# xfer

Allows for GET, POST calls with specialized protocols.

There is also 'fetch' for cached images.

## Getting Started

Supported Protocols:

- asset:// read a file from the app [GET, POST - same get]
- cached:// use caching to fetch cached images
- http:// https:// true network calls. [GET, POST]
- pref:// read/write bool, float, int, string with device preferences

## asset://

To read data from the device assets. (No such thing as PUT/POST as flutter assets are non-writeable)

```dart
Either<XferFailure, XferResponse> result = await Xfer().get('asset://images/brand.png', headers: 'Content-Type': 'image/png');
```

Content-Type supported:

- 'application/json'
- 'text/html'
- 'text/plain'
- 'image/gif'
- 'image/jpeg'
- 'image/jpg'
- 'image/png'

## cached://

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

## http://

Typical/Regular network call (GET, POST, PUT)

- GET

```dart
  Future<Either<XferFailure, XferResponse>> get(
    String url, {
    Map<String, String>? headers,
    Object? value,
```

- POST

```dart
Future<Either<XferFailure, XferResponse>> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    Object? value)
```

- PUT

```dart
Future<Either<XferFailure, XferResponse>> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    Object? value)
```

### NOTE

For these network request to work Xfer must be created with HTTP options for Get, Post, Put

```dart
import 'package:http/http.dart' as http;

final xfer = Xfer({
    httpPostFuture: http.post,
    httpPutFuture: http.put,
    httpGetFuture: http.get
    trace: false
  });

final result = await xfer.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic c3RldmVu123fghyoOkZIQ1AyMDIwIQ==',
    });
```

- Where httpGetFuture, httpPostFuture, httpPutFuture are provided from the developer or an existing package (eg: package:http/http.dart)
- This allows for GET, POST, PUT to be swizzled during development to mock 'real' network requests.
- 'trace', if true, writes additional console logs and include time for requests to complete

## pref:// or preference://

Read/Store simple types (**bool, double, integer, string**) on device.

- GET : reads data
- POST/PUT : writes data

```dart
/// GETs the value for 'myKey', with a default return value of 21 if it wasn't previously stored
Future<Either<XferFailure, XferResponse>> value = Xfer().get('pref://myKey', value: 21);

/// GETs the value for 'myKey', with a default return value of null if it wasn't previously stored
Future<Either<XferFailure, XferResponse>> value = Xfer().get('pref://myKey');

/// PUT writes the value 11 to on device store
Xfer().put('pref://myKey', value: 11);
```

## Special Note

Be kind to each other
