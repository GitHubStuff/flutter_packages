import 'package:flutter/material.dart';

import 'animated_action.dart';
import 'tick_mark.dart';


const _factor = 0.36;
const _filled = 0.18;
const _defaultBorderWidth = 2.0;
const _defaultDrawDelay = Duration(milliseconds: 50);
const _defaultDrawDuration = Duration(milliseconds: 550);

class AnimatedCheckBox extends StatefulWidget {
  final double sideLength;
  final AnimatedAction animatedAction;
  final bool containCheckMark;
  final Duration? animationDuration;
  final Color? checkmarkColor;
  final double? checkmarkStroke;
  final Color? boxColor;
  final double? borderWidgth;
  final Duration? drawDelay;

  const AnimatedCheckBox({
    Key? key,
    required this.animatedAction,
    required this.containCheckMark,
    required this.sideLength,
    this.checkmarkColor,
    this.checkmarkStroke,
    this.boxColor,
    this.animationDuration,
    this.borderWidgth,
    this.drawDelay,
  })  : assert(sideLength > 0.0),
        super(key: key);

  _AnimatedCheckBox createState() => _AnimatedCheckBox();
}

class _AnimatedCheckBox extends State<AnimatedCheckBox> with SingleTickerProviderStateMixin {
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
  Widget build(context) {
    final ThemeData theme = Theme.of(context);

    Future.delayed(widget.drawDelay ?? _defaultDrawDelay, () {
      widget.animatedAction == AnimatedAction.draw ? _animationController.forward() : _animationController.reset();
    });

    return SizedBox(
      width: widget.sideLength,
      height: widget.sideLength,
      child: _stack(theme),
    );
  }

  Widget _stack(ThemeData theme) {
    return Stack(
      children: [_box(theme), _checkmark()],
    );
  }

  Widget _box(ThemeData theme) {
    if (widget.borderWidgth == 0.0) return Container();
    final offset = widget.containCheckMark ? widget.sideLength * _filled : widget.sideLength * _factor;
    final devisor = widget.containCheckMark ? 1.0 : 2.0;
    return Container(
      margin: EdgeInsets.only(left: offset / devisor, right: offset, top: offset, bottom: offset / devisor),
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.boxColor ?? theme.primaryColor,
          width: widget.borderWidgth ?? _defaultBorderWidth,
        ),
      ),
    );
  }

  Widget _checkmark() {
    return TickMark(
      progress: _animation,
      size: widget.sideLength,
      strokeWidth: widget.checkmarkStroke,
      color: widget.checkmarkColor,
    );
  }
}
