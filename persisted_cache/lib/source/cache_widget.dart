import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extras/source/observing_stateful_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persisted_cache/source/cubit/popover_cubit.dart';

import 'cache_popover.dart';

final PopoverCubit _popoverCubit = PopoverCubit();

class CacheWidget extends StatefulWidget {
  final Widget parentWidget;

  CacheWidget({required this.parentWidget});

  @override
  _CacheWidget createState() => _CacheWidget();
}

class _CacheWidget extends ObservingStatefulWidget<CacheWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: Row(
          children: [
            GestureDetector(
              child: FaIcon(FontAwesomeIcons.list, size: 52.0),
              onTap: () {
                _popoverCubit.showPopover();
              },
            ),
            SizedBox(width: 16.0),
            _parent(),
          ],
        ),
      ),
    );
  }

  Widget _parent() {
    return BlocBuilder(
        bloc: _popoverCubit,
        builder: (cntx, state) {
          debugPrint('${DateTime.now()} $state');
          if (state is PopoverInitial) {
            return widget.parentWidget;
          }
          if (state is ShowPopover) {
            return _popover(widget.parentWidget);
          }
          if (mounted) return Text('WHOA!');
          return widget.parentWidget;
        });
  }

  Widget _popover(Widget parent) {
    return CachePopover<String>(
      cachedWidget: parent,
      cachePopoverCallback: (newTxt) {
        debugPrint('NEW TEXT: $newTxt');
        _popoverCubit.reset();
      },
      cachedItems: [],
      emptyCacheWidget: Text('WTF'),
      onPop: () {},
    );
  }
}
