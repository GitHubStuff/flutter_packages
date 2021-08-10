// Copyright 2021, LTMM, LLC.
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:popover/popover.dart';
import 'package:theme_manager/theme_manager.dart';

import '../conformation_popover.dart';

/// The colors that appears below the popover and obscures the screen beneath (low alpha transparency)
const ThemeColors _defaultBarrierColors = ThemeColors(
  dark: const Color(0x40ffffff),
  light: const Color(0x80000000),
);

const ThemeColors _defaultButtonColors = ThemeColors(
  dark: const Color(0xFFFBC02D),
  light: const Color(0x80000000),
);

/// Space between buttons, text body, etc
const double _defaultSpacing = 8.0;

/// Default animation time to draw/disappear the popover
const Duration _defaultTransition = const Duration(milliseconds: 250);

/// Max width a popover can be (A percentage of width on smaller devices)
const double _maxPoints = 350.0;

/// When the popover is dismissed there needs to be a delay before any callback is made to make sure the UIThread is cleaned up.
/// This is small millisecond delay.
const int _millisecondsAddedToTransitionOut = 5;

///For screens smaller thatn 350 the widget is multipled by this value
const double _screenWidthFactor = 0.8;

/// Default colors for popover border
ThemeColors _defaultBackgroundColors = ThemeColors(
  dark: Colors.white54,
  light: Colors.black87,
);

/// The color of the popover
ThemeColors _defaultCardColors = ThemeColors(
  dark: Colors.grey.shade900,
  light: Colors.white,
);

/// This Language DTO provides default text for all the popover text: title, caption, and buttons for supported languages
PromptDto _words = PromptDto({
  'en': {
    PromptDto.confirmChange: 'Confirm Change',
    PromptDto.caption: 'Please confirm your choice',
    PromptDto.change: 'Change',
    PromptDto.cancel: 'Cancel',
    PromptDto.thirdOption: 'Clear',
  },
  'es': {
    PromptDto.confirmChange: 'Confirmar cambio',
    PromptDto.caption: 'Confirma tu elección',
    PromptDto.change: 'Cambio',
    PromptDto.cancel: 'cancelar',
    PromptDto.thirdOption: 'Borrar',
  }
});

/// Displays a two or three button popover dialog for general use to confirm/cancel or confirm/clear/cancel option.
/// Each option has its own callback to user selection. The prompt appears above a parent widget.
class ConfirmationPopover extends StatelessWidget {
  /// Widget the popover will appear over
  final Widget parent;

  /// Animation Duration of how long it takes to expand/shrink the popover
  final Duration transistionDuration;

  /// Required call-back when the user taps the 'Confirm' Button
  final Function confirmCallback;

  /// Optional call-back when the user taps the 'Cancel' Button
  final Function? cancelCallback;

  /// Optional call-back if the user op's to have a 3rd button, if this is null no button appears
  final Function? secondButtonCallBack;

  /// This holds all the labels (title, caption, button) of localized Strings {see example at top}
  final PromptDto? languageDto;

  /// The color of the border around the popover
  final ThemeColors? backgroundColors;

  final ThemeColors? buttonColors;

  /// When the popover appears the lower view is obscured by this color (usual a color with low alpha for transparency)
  final ThemeColors? barrierColors;

  /// This is the color applied to the popover body
  final ThemeColors? cardColors;

  /// Optional leading widget (often an icon) that leads the title text
  final Widget? leadingWidget;

  /// Optional trailing widget (often an icon) that trails the title text
  final Widget? trailingWidget;

  /// Direction of the popover (default is TOP)
  final PopoverDirection direction;
  ConfirmationPopover(
    this.parent, {
    Key? key,
    required this.confirmCallback,
    this.backgroundColors,
    this.barrierColors,
    this.cancelCallback,
    this.cardColors,
    this.languageDto,
    this.leadingWidget,
    this.secondButtonCallBack,
    this.trailingWidget,
    this.transistionDuration = _defaultTransition,
    this.direction = PopoverDirection.top,
    this.buttonColors,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return _gestureDetector(context);
  }

  /// Wraps the 'parent' widget in a gesture detector that, on-tap, will showPopover.
  Widget _gestureDetector(BuildContext context) {
    final backgroundColor = (backgroundColors ?? _defaultBackgroundColors).of(context: context);
    final barrierColor = (barrierColors ?? _defaultBarrierColors).of(context: context);
    return GestureDetector(
      child: parent,
      onTap: () {
        showPopover(
          bodyBuilder: (context) => _popoverContent(context),
          direction: direction,
          transitionDuration: transistionDuration,
          context: context,
          barrierDismissible: false,
          backgroundColor: backgroundColor,
          barrierColor: barrierColor,
        );
      },
    );
  }

  /// Card widget that is the body of the popover. The card displays the header, subtitle, two buttons (confirm/cancel), and
  /// any optional leading/trailing widgets
  Widget _popoverContent(BuildContext context) {
    LanguageDto wordsDto = (languageDto ?? _words);
    final cardColor = (cardColors ?? _defaultCardColors).of(context: context);
    final Color buttonColor = (buttonColors ?? _defaultButtonColors).of(context: context);
    return SizedBox(
      width: min(context.width * _screenWidthFactor, _maxPoints),
      child: Card(
        color: cardColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: leadingWidget,
              trailing: trailingWidget,
              title: Padding(
                padding: const EdgeInsets.only(left: _defaultSpacing, right: _defaultSpacing, bottom: _defaultSpacing * 1.3),
                child: Center(
                  child: Text(
                    '${wordsDto.word(PromptDto.confirmChange)}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              subtitle: Center(child: Text('${wordsDto.word(PromptDto.caption)}')),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Text(
                    '${wordsDto.word(PromptDto.change)}',
                    style: TextStyle(color: buttonColor),
                  ),
                  onPressed: () {
                    Future.delayed(transistionDuration.add(Duration(milliseconds: _millisecondsAddedToTransitionOut)), () {
                      confirmCallback();
                    });
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: _defaultSpacing),
                (secondButtonCallBack == null)
                    ? SizedBox(height: 1)
                    : TextButton(
                        child: Text(
                          '${wordsDto.word(PromptDto.thirdOption)}',
                          style: TextStyle(color: buttonColor),
                        ),
                        onPressed: () {
                          Future.delayed(transistionDuration.add(Duration(milliseconds: _millisecondsAddedToTransitionOut)), () {
                            secondButtonCallBack!();
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                SizedBox(width: secondButtonCallBack == null ? 1 : _defaultSpacing),
                TextButton(
                  child: Text(
                    '${wordsDto.word(PromptDto.cancel)}',
                    style: TextStyle(color: buttonColor),
                  ),
                  onPressed: () {
                    if (cancelCallback != null) {
                      Future.delayed(transistionDuration.add(Duration(milliseconds: _millisecondsAddedToTransitionOut)), () {
                        cancelCallback!();
                      });
                    }
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: _defaultSpacing),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
