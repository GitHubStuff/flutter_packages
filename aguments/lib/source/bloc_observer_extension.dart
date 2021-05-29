// Copyright 2021 LTMM. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracers_package/tracers.dart';

/// Custom [BlocObserver] which observes all bloc and cubit instances.
/// NOTE: [Bloc.observer = SimpleBlocObserver();] before the call to [runApp] in [main.dart]

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    Log.V('⚡ $event');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase cubit, Change change) {
    Log.M('🦺$change');
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    Log.I('⚙️ $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase cubit, Object error, StackTrace stackTrace) {
    Log.E('🏮 $error');
    super.onError(cubit, error, stackTrace);
  }
}
