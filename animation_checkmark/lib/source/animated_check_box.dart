// Copyright 2021, LTMM
import 'package:flutter/material.dart';

import 'animated_action.dart';
import 'tick_mark.dart';

///* AnimatedCheckBox - Stateful widget that animates a check mark (inside or outside the box).
const _containedFactor = 0.15;
const _defaultBorderWidth = 2.0;
const _defaultDrawDelay = Duration(milliseconds: 50);
const _defaultDrawDuration = Duration(milliseconds: 550);

class AnimatedCheckBox extends StatefulWidget {
  final AnimatedAction animatedAction;
  final bool containCheckMark;
  final Color? boxColor;
  final Color? checkmarkColor;
  final double sideLength;
  final double? borderWidth;
  final double? checkmarkStroke;
  final Duration? animationDuration;
  final Duration? drawDelay;

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
  })  : assert(sideLength > 0.0),
        super(key: key);

  _AnimatedCheckBox createState() => _AnimatedCheckBox();
}

class _AnimatedCheckBox extends State<AnimatedCheckBox> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Color useNullColor;

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
  Widget build(context) {
    final ThemeData theme = Theme.of(context);
    useNullColor = (theme.brightness == Brightness.dark) ? theme.primaryColorDark : theme.primaryColorLight;

    Future.delayed(widget.drawDelay ?? _defaultDrawDelay, () {
      widget.animatedAction == AnimatedAction.draw ? _animationController.forward() : _animationController.reset();
    });

    return SizedBox(
      width: widget.sideLength,
      height: widget.sideLength,
      child: _stack(theme),
    );
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _stack(ThemeData theme) {
    return Stack(
      children: [_box(), _checkmark()],
    );
  }

  Widget _box() {
    if (widget.borderWidth == 0.0) return Container();
    final offset = widget.containCheckMark ? 0.0 : widget.sideLength * _containedFactor;
    return Container(
      margin: EdgeInsets.all(offset),
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.boxColor ?? useNullColor,
          width: widget.borderWidth ?? _defaultBorderWidth,
        ),
      ),
    );
  }

  Widget _checkmark() {
    return TickMark(
      progress: _animation,
      size: widget.sideLength,
      strokeWidth: widget.checkmarkStroke,
      color: widget.checkmarkColor ?? useNullColor,
      containCheckMark: widget.containCheckMark,
    );
  }
}
