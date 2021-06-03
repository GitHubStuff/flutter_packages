import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tracers_package/tracers.dart';

import '../xfer.dart';

class CachedHeader {
  static final String _placeholderKey = 'placeholderName';
  static final String _placeholderPackageKey = 'placeholderPackage';
  static final String _errorKey = 'errorName';
  static final String _errorPackageKey = 'errorPackage';
  static final String _width = 'width';
  static final String _height = "height";

  final String placeholderAssetName;
  final String placeholderPackage;
  final String errorAssetName;
  final String errorPackage;
  final String width;
  final String height;

  CachedHeader({
    this.placeholderAssetName = '',
    this.placeholderPackage = '',
    this.errorAssetName = '',
    this.errorPackage = '',
    this.width = '',
    this.height = '',
  });

  bool get usePlaceholder => placeholderAssetName.isNotEmpty;
  bool get useErrorAsset => errorAssetName.isNotEmpty;

  static CachedHeader? fromHeader(Map<String, String> header) {
    if (header[_placeholderKey] == null) return null;
    if (header[_errorKey] == null) return null;
    return CachedHeader(
      placeholderAssetName: header[_placeholderKey]!,
      placeholderPackage: header[_placeholderPackageKey] ?? '',
      errorAssetName: header[_errorKey]!,
      errorPackage: header[_errorPackageKey] ?? '',
      width: header[_width] ?? '',
      height: header[_height] ?? '',
    );
  }

  Map<String, String> asHeader() {
    Map<String, String> result = {};
    result[_placeholderKey] = placeholderAssetName;
    result[_placeholderPackageKey] = placeholderPackage;
    result[_errorKey] = errorAssetName;
    result[_errorPackageKey] = errorPackage;
    result[_width] = width;
    result[_height] = height;
    return result;
  }

  CachedNetworkImage cachedNetworkImage({required String url, CachedImageError? cachedImageError}) {
    List<String> elements = url.split('://');
    final String path = 'https://${elements[1]}';
    double? doubleWidth = (width.isEmpty) ? null : double.parse(width);
    double? doubleHeight = (height.isEmpty) ? null : double.parse(height);
    String? holder = (placeholderPackage.isEmpty) ? null : placeholderPackage;
    String? err = (errorPackage.isEmpty) ? null : errorPackage;
    return CachedNetworkImage(
      imageUrl: '$path',
      progressIndicatorBuilder: usePlaceholder
          ? null
          : (context, path, loaded) => CircularProgressIndicator(
                value: loaded.progress,
              ),
      placeholder: usePlaceholder ? (context, url) => Image(image: AssetImage(placeholderAssetName, package: holder)) : null,
      errorWidget: (context, url, error) {
        Log.F('CachedNetworkImage error: ${error.toString()}');
        if (cachedImageError != null) cachedImageError(error);
        return useErrorAsset ? Image(image: AssetImage(errorAssetName, package: err)) : Icon(Icons.error_outline_sharp);
      },
      width: doubleWidth,
      height: doubleHeight,
    );
  }
}
