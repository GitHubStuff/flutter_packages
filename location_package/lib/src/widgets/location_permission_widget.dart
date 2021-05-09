// Copyright 2021, LTMM
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location_package/location_package.dart';

/// Widget to display the platform specific alert dialog to open the location permissions control panel
/// to change LocationPermission to enable location permissions.
class LocationPermissionWidget extends StatelessWidget {
  final String title;
  final String content;
  final String openString;
  final String cancelString;
  final LocationService locationService;
  const LocationPermissionWidget({
    required this.locationService,
    required this.title,
    required this.content,
    required this.openString,
    required this.cancelString,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) return _android(context);
    if (Platform.isFuchsia) throw UnsupportedPlatform(platform: 'Fuchia');
    if (Platform.isIOS) return _ios(context);
    if (Platform.isLinux) throw UnsupportedPlatform(platform: 'Linux');
    if (Platform.isMacOS) throw UnsupportedPlatform(platform: 'MacOS');
    if (Platform.isWindows) throw UnsupportedPlatform(platform: 'Windows');
    throw UnsupportedPlatform(platform: Platform.operatingSystem);
  }

  Widget _ios(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
          onPressed: () async {
            Navigator.of(context).pop();
            await locationService.openIosLocationSettings();
          },
          child: Text(openString),
          isDefaultAction: true,
        ),
        CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(cancelString)),
      ],
    );
  }

  Widget _android(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(cancelString)),
        TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await locationService.openAndroidLocationSettings();
            },
            child: Text(openString)),
      ],
    );
  }
}
