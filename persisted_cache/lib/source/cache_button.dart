import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:popover/popover.dart';
import 'package:theme_manager/theme_manager.dart';

const _dismissDuration = const Duration(microseconds: 100);
const _listEdgeInsets = const EdgeInsets.symmetric(vertical: 2);
const _maximumLines = 2;
const _buttonSize = 32.0;

typedef void CachePopoverCallback(dynamic item);

class CacheButton<T> extends StatelessWidget {
  final CachePopoverCallback cachePopoverCallback;
  final String emptyCacheMessage;
  final List<T> cache;
  final ThemeColors? listTileColors;
  final ThemeColors? popoverColors;
  const CacheButton({
    Key? key,
    required this.emptyCacheMessage,
    required this.cache,
    required this.cachePopoverCallback,
    this.listTileColors,
    this.popoverColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        child: Row(
          children: [
            GestureDetector(
              child: FaIcon(FontAwesomeIcons.list, size: _buttonSize),
              onTap: () {
                /// Insure at least one cell for empty cache
                final double length = max(1.0, cache.length.toDouble());
                showPopover(
                  context: context,
                  bodyBuilder: (cntx) => Container(child: _column(context)),
                  direction: PopoverDirection.bottom,
                  height: min(60.0 * length, 60.0 * 3.5), // No more than 3.5 displayed to keep popover compact
                  width: min(400.0, context.size!.width * 0.95),
                  backgroundColor: popoverColors?.of(context: context) ??
                      ThemeColors(
                        dark: Color(0xff0047ab),
                        light: Colors.black54,
                      ).of(context: context),
                );
              },
            ),
            SizedBox(width: 16),
            Expanded(child: TextField()),
            SizedBox(width: 16),
            GestureDetector(
              child: Icon(
                Icons.move_to_inbox,
                size: _buttonSize,
              ), //FaIcon(FontAwesomeIcons.voteYea, size: _buttonSize),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget _column(BuildContext context) {
    final List<Widget> result = _listOfListTiles(cache.isEmpty ? [emptyCacheMessage] : cache, context);
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: result,
          ),
        ),
      ),
    );
  }

  List<Widget> _listOfListTiles(List<dynamic> items, BuildContext context) {
    List<Widget> result = [];
    items.forEach((item) => result.add(
          Padding(
            padding: _listEdgeInsets,
            child: Ink(
              child: ListTile(
                title: AutoSizeText(
                  item.toString(),
                  maxLines: _maximumLines,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  if (cache.isNotEmpty) cachePopoverCallback(item as dynamic);
                  Future.delayed(_dismissDuration, () {
                    Navigator.pop(context);
                  });
                },
                trailing: cache.isEmpty
                    ? null
                    : Icon(Icons.arrow_forward_ios,
                        color: ThemeColors(
                          dark: ThemeManager.darkTheme.textTheme.caption!.color!,
                          light: ThemeManager.lightTheme.textTheme.caption!.color!,
                        ).of(context: context)),
              ),
              color: listTileColors?.of(context: context) ??
                  ThemeColors(
                    dark: Color(0xAA000000),
                    light: Color(0xAAffffff),
                  ).of(context: context),
            ),
          ),
        ));
    return result;
  }
}
