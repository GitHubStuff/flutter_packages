// Copyright 2021 LTMM. All rights reserved.

part of 'default_themes.dart';

/// This is a private class the builds [MaterialApp TextStyle]
/// NOTE: It is intended as a [template] but should not require extensive (or any) changes.
/// NOTE:
/// ```dart
/// _kTypography
/// _displayFontFamily
/// ```
/// NOTE: Can be [changed] to alter the over all look/style of the app

class _TextThemeDefinations {
  static Typography get _kTypography => Typography.material2018(platform: TargetPlatform.iOS);
  static String get _displayFontFamily => '.SF UI Display'; //'Roboto';

  static final TextTheme light = _kTypography.white.copyWith(
    headline1: _kTypography.white.headline1!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.headline1],
      color: textColorLightMode[TextKey.headline1],
    ),
    headline2: _kTypography.white.headline2!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.headline2],
      color: textColorLightMode[TextKey.headline2],
    ),
    headline3: _kTypography.white.headline3!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.headline3],
      color: textColorLightMode[TextKey.headline3],
    ),
    headline4: _kTypography.white.headline4!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.headline4],
      color: textColorLightMode[TextKey.headline4],
    ),
    headline5: _kTypography.white.headline5!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.headline5],
      color: textColorLightMode[TextKey.headline5],
    ),
    headline6: _kTypography.white.headline6!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.headline6],
      color: textColorLightMode[TextKey.headline6],
    ),
    subtitle1: _kTypography.white.subtitle1!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.subtitle1],
      color: textColorLightMode[TextKey.subtitle1],
    ),
    subtitle2: _kTypography.white.subtitle2!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.subtitle2],
      color: textColorLightMode[TextKey.subtitle2],
    ),
    bodyText1: _kTypography.white.bodyText1!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.bodyText1],
      color: textColorLightMode[TextKey.bodyText1],
    ),
    bodyText2: _kTypography.white.bodyText2!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.bodyText2],
      color: textColorLightMode[TextKey.bodyText2],
    ),
    caption: _kTypography.white.caption!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.caption],
      color: textColorLightMode[TextKey.caption],
    ),
    button: _kTypography.white.button!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.button],
      color: textColorLightMode[TextKey.button],
    ),
    overline: _kTypography.white.overline!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.overline],
      color: textColorLightMode[TextKey.overline],
    ),
  );

  static final TextTheme dark = _kTypography.black.copyWith(
    headline1: _kTypography.black.headline1!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.headline1],
      color: textColorDarkMode[TextKey.headline1],
    ),
    headline2: _kTypography.black.headline2!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.headline2],
      color: textColorDarkMode[TextKey.headline2],
    ),
    headline3: _kTypography.black.headline3!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.headline3],
      color: textColorDarkMode[TextKey.headline3],
    ),
    headline4: _kTypography.black.headline4!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.headline4],
      color: textColorDarkMode[TextKey.headline4],
    ),
    headline5: _kTypography.black.headline5!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.headline5],
      color: textColorDarkMode[TextKey.headline5],
    ),
    headline6: _kTypography.black.headline6!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.headline6],
      color: textColorDarkMode[TextKey.headline6],
    ),
    subtitle1: _kTypography.black.subtitle1!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.subtitle1],
      color: textColorDarkMode[TextKey.subtitle1],
    ),
    subtitle2: _kTypography.black.subtitle2!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.subtitle2],
      color: textColorDarkMode[TextKey.subtitle2],
    ),
    bodyText1: _kTypography.black.bodyText1!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.bodyText1],
      color: textColorDarkMode[TextKey.bodyText1],
    ),
    bodyText2: _kTypography.black.bodyText2!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.bodyText2],
      color: textColorDarkMode[TextKey.bodyText2],
    ),
    caption: _kTypography.black.caption!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.caption],
      color: textColorDarkMode[TextKey.caption],
    ),
    button: _kTypography.black.button!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.button],
      color: textColorDarkMode[TextKey.button],
    ),
    overline: _kTypography.black.overline!.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKey.overline],
      color: textColorDarkMode[TextKey.overline],
    ),
  );
}
