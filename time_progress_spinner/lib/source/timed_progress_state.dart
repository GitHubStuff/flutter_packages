// Copyright 2020 LTMM, LLC. All rights reserved.
part of 'timed_progress_states.dart';

enum TimedWidgetBuilderState {
  TimedWidgetInitial,
  UpdateComplete,
  UpdateTimer,
}

abstract class TimedProgressState extends Equatable {
  final TimedWidgetBuilderState timedWidgetBuilderState;
  const TimedProgressState(this.timedWidgetBuilderState);

  @override
  List<Object> get props => [timedWidgetBuilderState];
}
