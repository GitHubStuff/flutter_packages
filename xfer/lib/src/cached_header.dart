import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedHeader {
  static final String _placeholderKey = 'placeholderName';
  static final String _placeholderPackageKey = 'placeholderPackage';
  static final String _errorKey = 'errorName';
  static final String _errorPackageKey = 'errorPackage';
  static final String _width = 'width';
  static final String _height = "height";

  final String placeholderAssetName;
  final String? placeholderPackage;
  final String errorAssetName;
  final String? errorPackage;
  final String? width;
  final String? height;

  CachedHeader({
    required this.placeholderAssetName,
    this.placeholderPackage,
    required this.errorAssetName,
    this.errorPackage,
    this.width,
    this.height,
  });

  static CachedHeader? fromHeader(Map<String, String?> header) {
    if (header[_placeholderKey] == null) return null;
    if (header[_errorKey] == null) return null;
    return CachedHeader(
      placeholderAssetName: header[_placeholderKey]!,
      placeholderPackage: header[_placeholderPackageKey],
      errorAssetName: header[_errorKey]!,
      errorPackage: header[_errorPackageKey],
      width: header[_width],
      height: header[_height],
    );
  }

  Map<String, String?> asHeader() {
    Map<String, String?> result = {};
    result[_placeholderKey] = placeholderAssetName;
    result[_placeholderPackageKey] = placeholderPackage;
    result[_errorKey] = errorAssetName;
    result[_errorPackageKey] = errorPackage;
    result[_width] = width;
    result[_height] = height;
    return result;
  }

  CachedNetworkImage cachedNetworkImage({required String url}) {
    double? doubleWidth = (width == null) ? null : double.parse(width!);
    double? doubleHeight = (height == null) ? null : double.parse(height!);
    return CachedNetworkImage(
      imageUrl: 'https://$url',
      placeholder: (context, url) => Image(image: AssetImage(placeholderAssetName, package: placeholderPackage)),
      errorWidget: (context, url, error) => Image(image: AssetImage(errorAssetName, package: errorPackage)),
      width: doubleWidth,
      height: doubleHeight,
    );
  }
}
