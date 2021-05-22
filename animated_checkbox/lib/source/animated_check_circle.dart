import 'package:flutter/material.dart';

import 'animated_action.dart';
import 'tick_mark.dart';

const _defaultBorderWidth = 2.0;
const _defaultDrawDelay = Duration(milliseconds: 50);
const _defaultDrawDuration = Duration(milliseconds: 550);

class AnimatedCheckCircle extends StatefulWidget {
  final double sideLength;
  final AnimatedAction animatedAction;
  final bool containCheckMark;
  final Duration? animationDuration;
  final Color? checkmarkColor;
  final double? checkmarkStroke;
  final Color? circleColor;
  final double? borderWidth;
  final Duration? drawDelay;

  const AnimatedCheckCircle({
    Key? key,
    required this.animatedAction,
    required this.containCheckMark,
    required this.sideLength,
    this.checkmarkColor,
    this.checkmarkStroke,
    this.circleColor,
    this.animationDuration,
    this.borderWidth,
    this.drawDelay,
  })  : assert(sideLength > 0.0),
        super(key: key);

  _AnimatedCheckCircle createState() => _AnimatedCheckCircle();
}

class _AnimatedCheckCircle extends State<AnimatedCheckCircle> with SingleTickerProviderStateMixin {
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
      child: _stack(),
    );
  }

  Widget _stack() {
    return Stack(
      children: [_box(), _checkmark()],
    );
  }

  Widget _box() {
    if (widget.borderWidth == 0.0) return Container();
    return Container(
      child: CustomPaint(
          painter: _OpenPainter(
        widget.sideLength,
        widget.borderWidth ?? _defaultBorderWidth,
        widget.circleColor ?? useNullColor,
      )),
      width: widget.borderWidth,
      height: widget.borderWidth,
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

class _OpenPainter extends CustomPainter {
  final double radius;
  final double stroke;
  final Color color;
  _OpenPainter(this.radius, this.stroke, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final offset = Offset(radius / 2.0, radius / 2.0);
    var paint1 = Paint()
      ..color = color
      ..strokeWidth = stroke
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(offset, this.radius / 3.0 + stroke, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
