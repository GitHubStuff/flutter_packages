// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../theme_package.dart';

/// Custom [BlocObserver] which observes all bloc and cubit instances.
/// NOTE: [Bloc.observer = SimpleBlocObserver();] before the call to [runApp] in [main.dart]

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    Log.V('⚡ $event');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    Log.M('🦺$change');
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    Log.I('⚙️ $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    Log.E('🏮 $error');
    super.onError(cubit, error, stackTrace);
  }
}
