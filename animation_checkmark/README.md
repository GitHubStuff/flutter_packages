# animation_checkmark

Collection of three(3) widgets that have an animated check-mark

* animated_check_box - check mark in/out of square box
* animated_check_circle - check mark in/out of a circle
* animated_check_mark - check mark with no container

## Getting Started

Add to pubspec.yaml

```ymal
  animation_checkmark:
    git:
      url: https://github.com/GitHubStuff/flutter_packages.git
      path: animation_checkmark
```

Import Package:

```dart
import 'package:animation_checkmark/animation_checkmark.dart';
```

**AnimatedCheckBox:**

```dart
const AnimatedCheckBox({
    Key? key,
    required this.animatedAction,
    required this.containCheckMark,
    required this.sideLength,
    this.animationDuration,
    this.borderWidth,
    this.boxColor,
    this.checkmarkColor,
    this.checkmarkStroke,
    this.drawDelay,
  });
```

* AnimatedAction animatedAction - forward/reset animate or erase check mark

* bool containCheckMark - T/F if the mark is bounded by the box

* double sideLength - Length of a check box side

* Duration animationDuration - Duration on animation

* double borderWidth - width of the check-box

* Color boxColor - color of the check-box

* Color checkmarkColor - color of the checkmark

* double checkmarkStroke - width of the checkmark

* Duration drawDelay - Wait time before draw begins

**AnimatedCheckCircle:**

```dart
const AnimatedCheckCircle({
    Key? key,
    required this.animatedAction,
    required this.containCheckMark,
    required this.sideLength,
    this.checkmarkColor,
    this.checkmarkStroke,
    this.circleColor,
    this.animationDuration,
    this.borderWidgth,
    this.drawDelay,
  });
```

* AnimatedAction animatedAction - forward/reset animate or erase check mark

* bool containCheckMark - T/F if the mark is bounded by the box

* double sideLength - radious of circle

* Color checkmarkColor - color of the checkmark

* double checkmarkStroke - width of the checkmark

* Color circleColor - color of the containing circle

* Duration animationDuration - Duration on animation

* double borderWidth - width of the circle

* Duration drawDelay - Wait time before draw begins

**AnimatedCheckMark:**

```dart
const AnimatedCheckMark({
    required this.animatedAction,
    required this.sideLength,
    this.animationDuration,
    this.checkmarkColor,
    this.checkmarkStroke,
    this.drawDelay,
  });
```

* AnimatedAction animatedAction - forward/reset animate or erase check mark

* double side length - height/width of Container widget that bounds the check mark

* Duration animationDuration - Duration on animation

* Color checkmarkColor - Color of the checkmark

* double checkmarkStroke - width of the checkmark

* Duration drawDelay - Wait time before draw begins

## SPECIAL NOTE

Be kind to each other
