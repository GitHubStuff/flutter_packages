// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

part of 'text_themes.dart';

/// This is a private class the builds [MaterialApp TextStyle]
/// NOTE: It is intended as a [template] but should not require extensive (or any) changes.
/// NOTE:
/// ```dart
/// _kTypography
/// _displayFontFamily
/// ```
/// NOTE: Can be [changed] to alter the over all look/style of the app

class _TextThemeDefinations {
  /// TODO: If desired make changes to [Typography] and [FontFamily], though iOS/SanFranciso looks best
  static Typography get _kTypography => Typography.material2018(platform: TargetPlatform.iOS);
  static String get _displayFontFamily => '.SF UI Display'; //'Roboto';

  static final TextTheme light = _kTypography.white.copyWith(
    headline1: _kTypography.white.headline1.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.headline1],
      color: textColorLightMode[TextKeys.headline1],
    ),
    headline2: _kTypography.white.headline2.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.headline2],
      color: textColorLightMode[TextKeys.headline2],
    ),
    headline3: _kTypography.white.headline3.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.headline3],
      color: textColorLightMode[TextKeys.headline3],
    ),
    headline4: _kTypography.white.headline4.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.headline4],
      color: textColorLightMode[TextKeys.headline4],
    ),
    headline5: _kTypography.white.headline5.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.headline5],
      color: textColorLightMode[TextKeys.headline5],
    ),
    headline6: _kTypography.white.headline6.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.headline6],
      color: textColorLightMode[TextKeys.headline6],
    ),
    subtitle1: _kTypography.white.subtitle1.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.subtitle1],
      color: textColorLightMode[TextKeys.subtitle1],
    ),
    subtitle2: _kTypography.white.subtitle2.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.subtitle2],
      color: textColorLightMode[TextKeys.subtitle2],
    ),
    bodyText1: _kTypography.white.bodyText1.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.bodyText1],
      color: textColorLightMode[TextKeys.bodyText1],
    ),
    bodyText2: _kTypography.white.bodyText2.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.bodyText2],
      color: textColorLightMode[TextKeys.bodyText2],
    ),
    caption: _kTypography.white.caption.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.caption],
      color: textColorLightMode[TextKeys.caption],
    ),
    button: _kTypography.white.button.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.button],
      color: textColorLightMode[TextKeys.button],
    ),
    overline: _kTypography.white.overline.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.overline],
      color: textColorLightMode[TextKeys.overline],
    ),
  );

  static final TextTheme dark = _kTypography.black.copyWith(
    headline1: _kTypography.black.headline1.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.headline1],
      color: textColorDarkMode[TextKeys.headline1],
    ),
    headline2: _kTypography.black.headline2.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.headline2],
      color: textColorDarkMode[TextKeys.headline2],
    ),
    headline3: _kTypography.black.headline3.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.headline3],
      color: textColorDarkMode[TextKeys.headline3],
    ),
    headline4: _kTypography.black.headline4.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.headline4],
      color: textColorDarkMode[TextKeys.headline4],
    ),
    headline5: _kTypography.black.headline5.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.headline5],
      color: textColorDarkMode[TextKeys.headline5],
    ),
    headline6: _kTypography.black.headline6.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.headline6],
      color: textColorDarkMode[TextKeys.headline6],
    ),
    subtitle1: _kTypography.black.subtitle1.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.subtitle1],
      color: textColorDarkMode[TextKeys.subtitle1],
    ),
    subtitle2: _kTypography.black.subtitle2.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.subtitle2],
      color: textColorDarkMode[TextKeys.subtitle2],
    ),
    bodyText1: _kTypography.black.bodyText1.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.bodyText1],
      color: textColorDarkMode[TextKeys.bodyText1],
    ),
    bodyText2: _kTypography.black.bodyText2.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.bodyText2],
      color: textColorDarkMode[TextKeys.bodyText2],
    ),
    caption: _kTypography.black.caption.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.caption],
      color: textColorDarkMode[TextKeys.caption],
    ),
    button: _kTypography.black.button.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.button],
      color: textColorDarkMode[TextKeys.button],
    ),
    overline: _kTypography.black.overline.copyWith(
      fontFamily: _displayFontFamily,
      fontSize: textSizeMap[TextKeys.overline],
      color: textColorDarkMode[TextKeys.overline],
    ),
  );
}
