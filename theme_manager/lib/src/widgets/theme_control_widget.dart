// Copyright 2021, LTMM
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../theme_manager.dart';

/// A widget that can be used to change themes (typically in the app bar)
class ThemeControlWidget extends StatelessWidget {
  final ThemeCubit themeCubit;
  const ThemeControlWidget({Key? key, required this.themeCubit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeCubitState>(
      bloc: themeCubit,
      builder: (cntx, state) {
        return Padding(
          padding: const EdgeInsets.only(right: 20, top: 12),
          child: GestureDetector(
            onTap: () => SetThemeDialog.show(context: context, themeCubit: themeCubit),
            child: ThemeCubit.themeModeIcon(context: context),
          ),
        );
      },
    );
  }
}
