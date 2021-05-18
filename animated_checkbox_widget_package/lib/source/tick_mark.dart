import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

const Point<double> _start = Point(0.27083, 0.54167);
const Point<double> _downPoint = Point(0.41667, 0.68750);
const Point<double> _upPoint = Point(0.75000, 0.35417);
const Point<double> _upWidePoint = Point(1.0000, 0.15417);
const double _strokeFactor = 0.06;

class TickMark extends StatefulWidget {
  final Animation<double> progress;
  final double size;
  final Color? color;
  final double? strokeWidth;
  final bool containCheckMark;

  TickMark({
    required this.progress,
    required this.size,
    this.color,
    this.strokeWidth,
    this.containCheckMark = true,
  });

  @override
  _TickMark createState() => _TickMark();
}

class _TickMark extends State<TickMark> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return CustomPaint(
      foregroundPainter: AnimatedPathPainter(
        widget.progress,
        widget.color ?? theme.primaryColor,
        widget.strokeWidth,
        widget.containCheckMark,
      ),
      child: SizedBox(
        width: widget.size,
        height: widget.size,
      ),
    );
  }
}

class AnimatedPathPainter extends CustomPainter {
  final Animation<double> _animation;
  final Color _color;
  final double? strokeWidth;
  final bool containCheckMark;

  AnimatedPathPainter(this._animation, this._color, this.strokeWidth, this.containCheckMark) : super(repaint: _animation);

  Path _createAnyPath(Size size) {
    final Point upPoint = (containCheckMark) ? _upPoint : _upWidePoint;
    return Path()
      ..moveTo(_start.x * size.width, _start.y * size.height)
      ..lineTo(_downPoint.x * size.width, _downPoint.y * size.height)
      ..lineTo(upPoint.x * size.width, upPoint.y * size.height);
  }

  Path createAnimatedPath(Path originalPath, double animationPercent) {
    final totalLength = originalPath.computeMetrics().fold(0.0, (double prev, PathMetric metric) => prev + metric.length);

    final currentLength = totalLength * animationPercent;

    return extractPathUntilLength(originalPath, currentLength);
  }

  Path extractPathUntilLength(Path originalPath, double length) {
    var currentLength = 0.0;

    final path = Path();

    var metricsIterator = originalPath.computeMetrics().iterator;

    while (metricsIterator.moveNext()) {
      var metric = metricsIterator.current;

      var nextLength = currentLength + metric.length;

      final isLastSegment = nextLength > length;
      if (isLastSegment) {
        final remainingLength = length - currentLength;
        final pathSegment = metric.extractPath(0.0, remainingLength);

        path.addPath(pathSegment, Offset.zero);
        break;
      } else {
        final pathSegment = metric.extractPath(0.0, metric.length);
        path.addPath(pathSegment, Offset.zero);
      }

      currentLength = nextLength;
    }

    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final animationPercent = this._animation.value;

    final path = createAnimatedPath(_createAnyPath(size), animationPercent);

    final Paint paint = Paint();
    paint.color = _color;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = strokeWidth ?? size.width * _strokeFactor;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
