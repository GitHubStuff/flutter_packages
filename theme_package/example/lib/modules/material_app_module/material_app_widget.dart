// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:theme_package/theme_package.dart';

import '../../localization/localization.dart';
import '../../main/flavor_enum.dart';

/// This is the template widget for [app_module].
/// NOTE: Should not need to be changed, it is [Bind] by [app_module.dart] this [MainModule] and because its
/// NOTE: uses [initalRoute], [navigatorKey], and [onGenerateRoute] is serves as the [MaterialApp] for the entire app

class MaterialAppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Constants.check(); // Ensure all [Constant] have a value
    final themeCubit = Modular.get<ThemeCubit>();
    final blocProvider = BlocProvider(
      create: (_) => themeCubit,
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, theme) {
          return MaterialApp(
            initialRoute: Navigator.defaultRouteName,
            navigatorKey: Modular.navigatorKey,
            debugShowCheckedModeBanner: false,
            // add Modular to manage the routing system
            onGenerateRoute: Modular.generateRoute,
            theme: theme,
            supportedLocales: [
              Locale('en'),
              Locale('es'),
            ],
            localizationsDelegates: [
              Localization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode && supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
          );
        },
      ),
    );

    /// Add a flavor [Banner] if provided and [not kReleaseMode]
    FlavorBanner flavorBanner = Modular.get<FlavorConfig>().flavorBanner;
    if (flavorBanner == null || flavorBanner.empty || kReleaseMode) return blocProvider;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Banner(
        location: flavorBanner.location ?? BannerLocation.topStart,
        message: flavorBanner.name,
        child: blocProvider,
        color: flavorBanner.color ?? Colors.redAccent,
      ),
    );
  }
}
