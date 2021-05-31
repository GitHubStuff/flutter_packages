// Copyright 2021, LTMM
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../src/cubit/theme_cubit.dart';
import '../../theme_manager.dart';
import 'set_theme_dialog.dart';

/// A widget that can be used to change themes (typically in the app bar)
class ThemeControlWidget extends StatelessWidget {
  const ThemeControlWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeCubitState>(
      bloc: ThemeManager.themeCubit,
      builder: (cntx, state) {
        return Padding(
          padding: const EdgeInsets.only(right: 20, top: 12),
          child: GestureDetector(
            onTap: () => SetThemeDialog.show(context: context),
            child: ThemeManager.themeModeIcon(context),
          ),
        );
      },
    );
  }
}
