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
  final Widget emptyCacheWidget;
  final ThemeColors? popoverColors;
  final ThemeColors? listTileColors;

  CachePopover({
    Key? key,
    required this.cachedWidget,
    required this.cachePopoverCallback,
    required this.cachedItems,
    required this.emptyCacheWidget,
    this.popoverColors,
    this.listTileColors,
  }) : super(key: key);

  @override
  _CachePopover<T> createState() => _CachePopover<T>();
}

class _CachePopover<U> extends ObservingStatefulWidget<CachePopover> {
  var _widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WidgetSize(
      onChange: (Size newSize) {
        _checkForEmptyCache(_picker(), newSize);
      },
      child: Container(
        key: _widgetKey,
        child: widget.cachedWidget,
      ),
    );
  }

  void _checkForEmptyCache(Widget picker, Size size) {
    widget.cachedItems.isEmpty ? _noCachedItemsPicker(widget.emptyCacheWidget, size) : _showPopover(picker, size);
  }

  List<Widget> _listOfListTiles<U>(List<U> items) {
    List<Widget> result = [];
    items.forEach((item) => result.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Ink(
              child: ListTile(
                title: AutoSizeText(
                  item.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  widget.cachePopoverCallback(item);
                  Future.delayed(Duration(microseconds: 100), () {
                    Navigator.pop(context);
                  });
                },
                trailing: Icon(Icons.arrow_forward_ios,
                    color: ThemeColors(
                      dark: ThemeManager.darkTheme.textTheme.caption!.color!,
                      light: ThemeManager.lightTheme.textTheme.caption!.color!,
                    ).of(context: context)),
              ),
              color: widget.listTileColors?.of(context: context) ??
                  ThemeColors(
                    dark: Color(0xAA000000),
                    light: Color(0xAAffffff),
                  ).of(context: context),
            ),
          ),
        ));
    return result;
  }

  void _noCachedItemsPicker(Widget emptyCacheWidget, Size size) {
    Widget content = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Ink(
        child: ListTile(
          title: Container(
            child: emptyCacheWidget,
            height: size.height,
            width: size.width,
          ),
          onTap: () {
            Future.delayed(Duration(microseconds: 100), () {
              Navigator.pop(context);
            });
          },
        ),
        color: widget.listTileColors?.of(context: context) ??
            ThemeColors(
              dark: Color(0xAA000000),
              light: Color(0xAAffffff),
            ).of(context: context),
      ),
    );
    showPopover(
        context: context,
        bodyBuilder: (context) => SizedBox(child: content, width: size.width),
        backgroundColor: widget.popoverColors?.of(context: context) ??
            ThemeColors(
              dark: Color(0xff0047ab),
              light: Colors.black54,
            ).of(context: context));
  }

  Widget _picker() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SingleChildScrollView(
          child: Column(
        children: _listOfListTiles(widget.cachedItems),
      )),
    );
  }

  void _showPopover(Widget picker, Size size) {
    showPopover(
        context: context,
        bodyBuilder: (context) => picker,
        width: size.width * 1.10,
        height: size.height * 8.5,
        backgroundColor: widget.popoverColors?.of(context: context) ??
            ThemeColors(
              dark: Color(0xff0047ab),
              light: Colors.black54,
            ).of(context: context));
  }
}
