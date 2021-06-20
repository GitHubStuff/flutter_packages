import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:popover/popover.dart';
import 'package:theme_manager/theme_manager.dart';

typedef void CachePopoverCallback<T>(T item);

class CachePopover<T> extends StatefulWidget {
  final CachePopoverCallback<T> cachePopoverCallback;
  final Widget cachedWidget;
  final List<T> cachedItems;

  CachePopover({
    Key? key,
    required this.cachedWidget,
    required this.cachePopoverCallback,
    required this.cachedItems,
  }) : super(key: key);

  @override
  _CachePopover createState() => _CachePopover();
}

class _CachePopover extends ObservingStatefulWidget<CachePopover> {
  var _widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WidgetSize(
      onChange: (Size newSize) {
        _showPopover(_picker(), newSize);
      },
      child: Container(
        key: _widgetKey,
        child: widget.cachedWidget,
      ),
    );
  }

  void _showPopover(Widget picker, Size size) {
    showPopover(
        context: context,
        bodyBuilder: (context) => picker,
        width: size.width * 1.10,
        height: size.height * 8.5,
        backgroundColor: ThemeColors(
          dark: Color(0xff0047ab),
          light: Colors.black54,
        ).of(context: context));
  }

  Widget _picker() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SingleChildScrollView(
          child: Column(
        children: _listOfListTiles(),
      )),
    );
  }

  List<Widget> _listOfListTiles() {
    List<Widget> result = [];
    widget.cachedItems.forEach((item) => result.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Ink(
              child: ListTile(
                title: AutoSizeText(
                  item.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_forward_ios,
                    color: ThemeColors(
                      dark: ThemeManager.darkTheme.textTheme.caption!.color!,
                      light: ThemeManager.lightTheme.textTheme.caption!.color!,
                    ).of(context: context)),
              ),
              color: ThemeColors(
                dark: Color(0xAA000000),
                light: Color(0xAAffffff),
              ).of(context: context),
            ),
          ),
        ));
    return result;
  }
}
