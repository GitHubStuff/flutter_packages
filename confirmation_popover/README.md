# confirmation_popover

Popover widget that forces the user to 'Confirm' or 'Cancel' an option. It's annoying quirk from the Microsoft Window's World where you're treated like a moron and you have to confirm everything.


It also has "Third" button option as well for three choices.

## Getting Started

```dart
import 'package:confirmation_popover/conformation_popover.dart';


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
    this.transistionDuration = const Duration(milliseconds: 250),
    this.direction = PopoverDirection.top,
  })
```

#### Two Button Popover

To have a two-button popover just leave 'secondButtonCallBack' = null.

#### Three Button Popover

To have a three button callback provided a non-null value to 'secondButtonCallBack'

### INFO

- There are 'okay' default colors for dark/light themes for the popover border, the barrier color, and popover background

- barrier colors should have a low alpha (<= 0.5) to let some of the lower view below the popover appear.

- The default prompts are 'okay' => "Confirm Change", "Please confirm your choice", "Confirm", "Cancel", "Clear"

### REQUIRED

To insure that all the key/value pairs are in place for each locale the **LanguageDto** can be created with **PromptDto**

```dart
typedef WordList = Map<String, Map<String, String>>;

PromptDto(WordList wordList) : extends LanguageDto and 'asserts' if any keys are missing.

factory PromptDto.threeButtons(WordList wordList) : checks to make sure there is a third button text caption
```

## Final Note

Be kind to each other!
