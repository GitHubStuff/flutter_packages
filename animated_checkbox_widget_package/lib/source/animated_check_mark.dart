import 'package:flutter/material.dart';

import 'animated_action.dart';
import 'tick_mark.dart';

const _defaultDrawDelay = Duration(milliseconds: 50);
const _defaultDrawDuration = Duration(milliseconds: 550);

class AnimatedCheckMark extends StatefulWidget {
  final double sideLength;
  final Duration? animationDuration;
  final Duration? drawDelay;
  final Color? checkmarkColor;
  final double? checkmarkStroke;
  final AnimatedAction animatedAction;

  const AnimatedCheckMark({
    this.animationDuration,
    required this.sideLength,
    required this.animatedAction,
    this.drawDelay,
    this.checkmarkColor,
    this.checkmarkStroke,
  });
  @override
  _AnimatedCheckMark createState() => _AnimatedCheckMark();
}

class _AnimatedCheckMark extends State<AnimatedCheckMark> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? _defaultDrawDuration,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCirc),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(widget.drawDelay ?? _defaultDrawDelay, () {
      widget.animatedAction == AnimatedAction.draw ? _animationController.forward() : _animationController.reset();
    });

    return TickMark(
      progress: _animation,
      size: widget.sideLength,
      strokeWidth: widget.checkmarkStroke,
      color: widget.checkmarkColor,
    );
  }
}
