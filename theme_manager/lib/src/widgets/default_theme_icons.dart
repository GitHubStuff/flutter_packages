import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'theme_icons.dart';

class DefaultThemeIcons implements ThemeIcons {
  Widget get applicationDark => FaIcon(FontAwesomeIcons.solidMoon, color: Colors.grey[400]);
  Widget get applicationLight => FaIcon(FontAwesomeIcons.solidSun, color: Colors.yellow[600]);
  Widget get platformDark => FaIcon(FontAwesomeIcons.lightbulb, color: Colors.grey[400]);
  Widget get platformLight => FaIcon(FontAwesomeIcons.solidLightbulb, color: Colors.yellow[600]);
  Widget get platform => FaIcon(FontAwesomeIcons.sun, color: Colors.amber[600]);
}
