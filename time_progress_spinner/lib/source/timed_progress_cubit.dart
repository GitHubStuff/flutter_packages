// Copyright 2021 LTMM. All rights reserved.

import 'package:bloc/bloc.dart';
import 'package:timed_progress_spinner/source/timed_progress_states.dart';

class TimedProgressCubit extends Cubit<TimedProgressState> {
  bool _cancelUpdates = false;

  TimedProgressCubit() : super(TimedWidgetInitial());

  void cancelTimerUpdates() async => _cancelUpdates = true;

  void updatingTimer(Duration duration) async {
    _cancelUpdates = false;

    /// Calculate when the timer will finish
    final DateTime finish = DateTime.now().add(duration.abs());
    double pct = 1.0;
    Duration interval = finish.difference(DateTime.now());
    while (!interval.isNegative && !_cancelUpdates) {
      emit(UpdateTimer(pct, interval));
      pct = 1.0 - (duration.inMilliseconds - interval.inMilliseconds) / duration.inMilliseconds;
      if (duration.isNegative) pct = 1.0 + pct;
      if (!_cancelUpdates) await Future.delayed(Duration(milliseconds: 100));
      interval = finish.difference(DateTime.now());
    }
    emit(UpdateComplete());
  }
}
