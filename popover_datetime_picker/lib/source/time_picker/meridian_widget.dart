// Copyright 2021, LTMM LLC
import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:popover_datetime_picker/source/cubit/date_time_cubit.dart';

import '../constants.dart' as K;
import '../widgets/list_wheel.dart';
import '../widgets/picker_text.dart';

class MeridianWidget extends StatefulWidget {
  final Size size;
  final double offAxisFraction;

  const MeridianWidget({
    Key? key,
    required this.size,
    this.offAxisFraction = 0.0,
  }) : super(key: key);

  @override
  _MeridianWidget createState() => _MeridianWidget();
}

class _MeridianWidget extends ObservingStatefulWidget<MeridianWidget> {
  double get extent => widget.size.height * K.scrollWheelExtent;
  final scrollController = FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext buildContext) {
    DateTimeCubit dateTimeCubit = DateTimeCubit.cubit;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {
        //debugPrint('Scrolling');
      });
      scrollController.position.isScrollingNotifier.addListener(() {
        if (!scrollController.position.isScrollingNotifier.value) {
          final pos = scrollController.selectedItem;
          dateTimeCubit.changeMeridian(index: pos);
        } else {}
      });
    });
    final pos = dateTimeCubit.meridianIndex;
    scrollController.jumpToItem(pos);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: _listWheelWidget(),
    );
  }

  Widget _listWheelWidget() => ListWheel(
        scrollController: scrollController,
        extent: extent,
        delegate: _delegate(),
        offAxisFraction: widget.offAxisFraction,
      );

  ListWheelChildBuilderDelegate _delegate() {
    return ListWheelChildBuilderDelegate(builder: (context, int index) {
      if (index != K.amIndex && index != K.pmIndex) return null;
      final text = (index == K.amIndex ? K.midnight : K.noon).asMeridian();
      return PickerText(text: text);
    });
  }
}
