// Copyright 2021, LTMM LLC
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:keypad_popover/cubit/keypad_cubit.dart';
import 'package:keypad_popover/keypad_popover.dart';
import 'package:popover/popover.dart';
import 'package:theme_manager/theme_manager.dart';

import 'constants.dart' as K;
import 'number_bar.dart';

typedef void KeypadCallback(String value);

/// This is the 'Gateway' widget where the popover is defined, other .dart "serve/support" this widget
/// Wraps the host widget in a container so the Popover package will appear by the widget.
class KeypadPopover extends StatefulWidget {
  final Widget onWidget;
  final KeypadCallback callback;
  final bool includeSeconds;
  final ThemeColors backgroundColors;
  final ThemeColors buttonColors;

  KeypadPopover({
    Key? key,
    required this.onWidget,
    required this.callback,
    this.includeSeconds = true,
    this.backgroundColors = K.defaultBackgroundColors,
    this.buttonColors = K.buttonColors,
  }) : super(key: key);

  @override
  _KeypadPopover createState() => _KeypadPopover();
}

class _KeypadPopover extends ObservingStatefulWidget<KeypadPopover> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final keypadCubit = Modular.get<KeypadCubit>();

    return BlocBuilder<KeypadCubit, KeypadState>(
      bloc: keypadCubit,
      builder: (context, state) {
        if (state is KeypadValueSet) {
          widget.callback(state.value);
          keypadCubit.reset();
          Navigator.of(context).pop();
        }
        return GestureDetector(
          child: widget.onWidget,
          onTap: () {
            showPopover(
              backgroundColor: widget.backgroundColors.of(context: context),
              context: context,
              bodyBuilder: (context) => _picker(),
              onPop: () {},
            );
          },
        );
      },
    );
  }

  Widget _picker() {
    return NumberBar(widget.buttonColors);
  }
}
