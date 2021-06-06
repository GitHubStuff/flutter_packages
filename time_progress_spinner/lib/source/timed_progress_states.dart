// Copyright 2020 LTMM, LLC. All rights reserved.
import 'package:equatable/equatable.dart';

part 'timed_progress_state.dart';

/// Classes for the cubit state
class TimedWidgetInitial extends TimedProgressState {
  const TimedWidgetInitial() : super(TimedWidgetBuilderState.TimedWidgetInitial);
}

class UpdateComplete extends TimedProgressState {
  const UpdateComplete() : super(TimedWidgetBuilderState.UpdateComplete);
}

class UpdateTimer extends TimedProgressState {
  final Duration duration;
  final double pct;
  const UpdateTimer(this.pct, this.duration) : super(TimedWidgetBuilderState.UpdateTimer);
  @override
  List<Object> get props => [pct, timedWidgetBuilderState];
}
