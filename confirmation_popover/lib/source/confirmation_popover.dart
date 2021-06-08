import 'package:confirmation_popover/conformation_popover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:popover/popover.dart';
import 'package:theme_manager/theme_manager.dart';

const String _confirmChange = 'confirmChange';
const String _caption = 'caption';
const String _confirm = 'confirm';
const String _cancel = 'cancel';

PromptDto _words = PromptDto({
  'en': {
    'confirmChange': 'Confirm Change',
    'caption': 'Please confirm your choice',
    'confirm': 'Confirm',
    'cancel': 'Cancel',
  },
  'es': {
    'confirmChange': 'Confirmar cambio',
    'caption': 'Confirma tu elección',
    'confirm': 'confirmar',
    'cancel': 'cancelar',
  }
});

class ConfirmationPopover extends StatelessWidget {
  final Widget parent;
  final Function confirmCallback;
  final LanguageDto? languageDto;
  final ThemeColors? backgroundColors;
  final ThemeColors? barrierColors;
  final ThemeColors? cardColors;
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  ConfirmationPopover(
    this.parent, {
    Key? key,
    required this.confirmCallback,
    this.languageDto,
    this.backgroundColors,
    this.barrierColors,
    this.cardColors,
    this.leadingWidget,
    this.trailingWidget,
  }) : super(key: key);

  /// Wraps the 'parent' widget in a gesture detector that, on-tap, will showPopover.
  Widget _wrapped(BuildContext context) {
    final backgroundColor = (backgroundColors ??
            ThemeColors(
              dark: Colors.white54,
              light: Colors.black87,
            ))
        .of(context: context);
    final barrierColor = (barrierColors ??
            ThemeColors(
              dark: const Color(0x40ffffff),
              light: const Color(0x80000000),
            ))
        .of(context: context);
    return GestureDetector(
      child: parent,
      onTap: () {
        showPopover(
          bodyBuilder: (context) {
            return _card(context);
          },
          direction: PopoverDirection.top,
          context: context,
          barrierDismissible: false,
          backgroundColor: backgroundColor,
          barrierColor: barrierColor,
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return _wrapped(context);
  }

  /// Card widget that is the body of the popover. The card displays the header, subtitle, two buttons (confirm/cancel), and
  /// any optional leading/trailing widgets
  Widget _card(BuildContext context) {
    LanguageDto wordsDto = (languageDto ?? _words);
    
    final cardColor = (cardColors ??
            ThemeColors(
              dark: Colors.grey.shade900,
              light: Colors.white,
            ))
        .of(context: context);
    return SizedBox(
      width: context.width < 500.0 ? context.width * 0.80 : 500.0,
      child: Card(
        color: cardColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: leadingWidget,
              trailing: trailingWidget,
              title: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('${wordsDto.word(_confirmChange)}'),
              ),
              subtitle: Text('${wordsDto.word(_caption)}'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Text('${wordsDto.word(_confirm)}'),
                  onPressed: () {
                    confirmCallback();
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: Text('${wordsDto.word(_cancel)}'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
