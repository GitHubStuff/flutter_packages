// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Holds the properties of the optional [Banner] that can be placed
/// in the corner of the app.
/// NOTE: based on [Flavor] of app (debug, test, ...) can provide visual cue of the flavor running

class FlavorBanner {
  final String name;
  final Color color;
  final BannerLocation location;

  FlavorBanner({
    this.name,
    this.color = Colors.red,
    this.location = BannerLocation.topStart,
  });

  bool get empty => (name == null);
}
