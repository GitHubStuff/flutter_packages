import 'package:flutter_modular/flutter_modular.dart';

import '../modular_transitions.dart';
import 'rotated.dart';

class Transition {
  final Transitions transition;
  final Duration duration;
  const Transition(this.transition, {required this.duration});
}

CustomTransition get myCustomTransition => CustomTransition(
      transitionDuration: Duration(milliseconds: 500),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Rotated(
          animation: animation,
          child: child,
        );
      },
    );
