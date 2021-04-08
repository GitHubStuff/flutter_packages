// Copyright 2021 LTMM. All rights reserved.
library theme_package;

export 'src/cubit_theme/theme_cubit.dart';
export 'src/helpers/colors_for_theme.dart';
export 'src/helpers/simple_bloc_observer.dart';
export 'src/helpers/theme_text_style.dart';
export 'src/theme/flavor_banner.dart';
export 'src/theme/flavor_config.dart';
export 'src/theme/theme_preference.dart';
export 'src/theme/theme_type_extension.dart';
export 'src/widgets/observing_stateful_widget.dart';

/// There are four(4) types of [brightness], two(2) for the [device brightness]
/// and two(2) [application brightness] if the app [overrides] the device brightness.
/// NOTE: [unknown] is for [application launch] before the [ThemeType] is [loaded from preferences]
enum ThemeType {
  applicationLight,
  applicationDark,
  platformLight,
  platformDark,
  unknown,
}
