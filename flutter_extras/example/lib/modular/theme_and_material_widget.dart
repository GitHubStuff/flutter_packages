import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:theme_management_package/theme_management_package.dart';

class ThemeAndMaterialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeCubit = Modular.get<ThemeCubit>();
    return BlocBuilder<ThemeCubit, ThemeCubitState>(
        bloc: themeCubit,
        builder: (_, state) {
          ThemeMode themeMode = ThemeCubit.themeMode;
          if (state is UpdateThemeMode) {}
          return MaterialApp(
            title: 'Flutter Demo',
            theme: themeCubit.lightTheme,
            darkTheme: themeCubit.darkTheme,
            themeMode: themeMode,
            initialRoute: '/',
          ).modular();
        });
  }
}
