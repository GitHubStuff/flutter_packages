# confirmation_popover

Popover widget that forces the user to 'Confirm' or 'Cancel' an option. It's annoying feature from the Window's World where you're treated like a moron and you have to confirm everything.

## Getting Started

```dart
import 'package:confirmation_popover/conformation_popover.dart';


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

```

where:

- parent : The widget that the popover will hover over
- comfirmCallback : zero argument function that is called if the user selects the 'Confirm' option.
- languageDto : holds all the prompts used in the dialog
- backgroundColors : dark/light mode colors for the border of the popover
- barrierColors : dark/light mode colors that obscure the screen when the popover appears
- cardColros : dart/light mode colors for the background color of the card
- leadingWidget : widget that appears to the far left of the card
- trailingWidget : widget that appears to the far right of the card
- key: flutter key

## HELPER

To insure that all the key/value pairs are in place for each locale the **LanguageDto** can be created with **PromptDto**

```dart
PromptDto(Map<String, Map<String, String>> wordList) : extends LanguageDto and 'asserts' if any keys are missing.
```

## Final Note

Be kind to each other!
