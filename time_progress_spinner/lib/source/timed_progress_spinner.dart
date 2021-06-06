// Copyright 2021 LTMM, LLC. All rights reserved.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'timed_progress_cubit.dart';
import 'timed_progress_states.dart';

class TimedProgressSpinner extends StatefulWidget {
  final Duration duration;
  final Function(double, Duration) callback;
  final Function completion;
  const TimedProgressSpinner({
    Key? key,
    required this.duration,
    required this.callback,
    required this.completion,
  }) : super(key: key);
  @override
  _TimedProgressSpinner createState() => _TimedProgressSpinner();
}

class _TimedProgressSpinner extends State<TimedProgressSpinner> {
  double _value = 0.5;

  @override
  Widget build(BuildContext context) {
    TimedProgressCubit _timedWidgetCubit = TimedProgressCubit();
    return BlocBuilder<TimedProgressCubit, TimedProgressState>(
        bloc: _timedWidgetCubit,
        builder: (context, sensorState) {
          switch (sensorState.timedWidgetBuilderState) {
            case TimedWidgetBuilderState.TimedWidgetInitial:
              _timedWidgetCubit.updatingTimer(widget.duration);
              break;
            case TimedWidgetBuilderState.UpdateComplete:
              _value = (widget.duration.isNegative) ? 1.0 : 0.0;
              widget.completion();
              break;
            case TimedWidgetBuilderState.UpdateTimer:
              final info = (sensorState as UpdateTimer);
              _value = info.pct;
              widget.callback(_value, info.duration);
          }
          return CircularProgressIndicator(
            value: _value,
            color: Colors.red,
          );
        });
  }
}
