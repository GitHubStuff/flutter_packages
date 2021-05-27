import 'package:flutter/material.dart';

class Rotated extends AnimatedWidget {
  final Alignment alignment;
  final Animation<double> animation;
  final Widget child;
  const Rotated({
    Key? key,
    this.alignment = Alignment.center,
    required this.child,
    required this.animation,
  }) : super(
          key: key,
          listenable: animation,
        );
  AnimatedWidget build(BuildContext context) {
    return RotationTransition(
      turns: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Interval(
                0.00,
                0.50,
                curve: Curves.linear,
              ),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
