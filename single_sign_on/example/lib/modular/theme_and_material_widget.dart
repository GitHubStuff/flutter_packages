import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:theme_manager/theme_manager.dart';

class ThemeAndMaterialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeCubitState>(
        bloc: ThemeManager.themeCubit,
        builder: (_, state) {
          ThemeMode themeMode = ThemeManager.themeMode;
          if (state is UpdateThemeMode) {}
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeManager.lightTheme,
            darkTheme: ThemeManager.darkTheme,
            themeMode: themeMode,
            initialRoute: '/',
            localizationsDelegates: [
              AppLocalizations.delegate,  //Used to translate strings in /l10n/app_en.arb or /l10n/app_es.arb files
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''), // English, no country code
              const Locale('es', ''), // Spanish, no country code
            ],
          ).modular();
        });
  }
}
