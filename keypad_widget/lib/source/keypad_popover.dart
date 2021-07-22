// Copyright 2021, LTMM LLC
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:keypad_popover/cubit/keypad_cubit.dart';
import 'package:keypad_popover/keypad_popover.dart';
import 'package:popover/popover.dart';

import 'number_bar.dart';

typedef void KeypadCallback(String value);

/// This is the 'Gateway' widget where the popover is defined, other .dart "serve/support" this widget
/// Wraps the host widget in a container so the Popover package will appear by the widget.
class KeypadPopover extends StatefulWidget {
  final Widget onWidget;
  final KeypadCallback callback;
  final bool includeSeconds;

  KeypadPopover({
    Key? key,
    required this.onWidget,
    required this.callback,
    this.includeSeconds = true,
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
              backgroundColor: Colors.grey,
              //backgroundColor: ThemeManager.color(K.captionColors, context: context),
              context: context,
              bodyBuilder: (context) => _picker(),
              onPop: () {
                debugPrint('POP!');
              },
              // width: K.minimalPopoverSize.width,
              //height: 500.0,
              //width: 400.0,
              // arrowHeight: K.popoverArrowHeight,
              // arrowWidth: K.popoverArrowWidth,
            );
          },
        );
      },
    );
  }

  Widget _picker() {
    return NumberBar();
  }
}
