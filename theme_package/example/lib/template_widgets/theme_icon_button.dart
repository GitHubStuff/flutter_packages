// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

/// Creates an [IconButton] that can be used for [setting light/dark/device theme]

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../template_widgets/set_theme_dialog.dart';

class ThemeIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  const ThemeIconButton({Key key, this.icon, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final callback = onPressed ?? () => SetThemeDialog.show(context);
    final widget = icon ?? FaIcon(FontAwesomeIcons.palette);
    return IconButton(
      icon: widget,
      onPressed: callback,
    );
  }
}
