// Copyright 2021, LTTM LLC.
// Custom Icon with three(3) widgets - Displays List of Cached Items as Popover, TextField to edit/enter items, Submits content
// of the TextField to the list of cached items.
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:popover/popover.dart';
import 'package:theme_manager/theme_manager.dart';

import '../persisted_cache.dart';
import '../source/cubit/cache_cubit.dart';

const _buttonSize = 32.0;
const _dismissDuration = const Duration(microseconds: 100);
const _listEdgeInsets = const EdgeInsets.symmetric(vertical: 2);
const _maximumLines = 2;

String _cachedString = '';
Key _uniqueKey = UniqueKey();

typedef void CachePopoverCallback(dynamic item);

class CachedWidget extends StatefulWidget {
  /// Callback that will get the value in the TextField when the Submit is tapped
  final CachePopoverCallback cachePopoverCallback;

  /// String to display if there are no cached items
  final String emptyCacheMessage;

  /// PersistedCache that feeds the TextField and/or adds new items to the cache list
  final PersistedCache persistedCache;

  /// Colors for the ListTile that make up the list of cached items (or emptyCacheMessage message)
  final ThemeColors? listTileColors;

  /// Colors of the popover background/border colors
  final ThemeColors? popoverColors;
  CachedWidget({
    Key? key,
    required this.persistedCache,
    required this.emptyCacheMessage,
    required this.cachePopoverCallback,
    this.listTileColors,
    this.popoverColors,
  }) : super(key: key);
  @override
  _CachedWidget createState() => _CachedWidget();
}

class _CachedWidget extends ObservingStatefulWidget<CachedWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  final CacheCubit _cacheCubit = CacheCubit();

  void clear() => _textEditingController.clear();

  @override
  dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        child: Row(
          children: [
            _cachedWidget(context),
            SizedBox(width: 16),
            _textField(context),
            SizedBox(width: 16),
            _submitIcon(context),
          ],
        ),
      ),
    );
  }

  /// Show the popover of cached strings
  Widget _cachedWidget(BuildContext context) {
    return GestureDetector(
      child: FaIcon(FontAwesomeIcons.list, size: _buttonSize),
      onTap: () {
        SystemSound.play(SystemSoundType.click);

        /// Insure at least one cell for empty cache
        final double length = max(1.0, widget.persistedCache.cachedItems().length.toDouble());
        showPopover(
          context: context,
          bodyBuilder: (cntx) => Container(child: _column(context)),
          direction: PopoverDirection.bottom,
          height: min(60.0 * length, 60.0 * 3.5), // No more than 3.5 displayed to keep popover compact
          width: min(400.0, context.size!.width * 0.95),
          backgroundColor: widget.popoverColors?.of(context) ??
              ThemeColors(
                dark: Color(0xff0047ab),
                light: Colors.black54,
              ).of(context),
        );
      },
    );
  }

  /// Gets the list of cached strings and turns them into scrollable list of Widgets containing Text widgets of the Strings
  Widget _column(BuildContext context) {
    List<dynamic> cache = widget.persistedCache.cachedItems();
    final List<Widget> result = _listOfListTiles(cache.isEmpty ? [widget.emptyCacheMessage] : cache, context);
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

  /// Builds a list of ListTile widgets to change the cached strings into usable/tappable tiles
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
                  if (!widget.persistedCache.isEmpty) {
                    _cacheCubit.setViewText(item as String);
                  }
                  Future.delayed(_dismissDuration, () {
                    Navigator.pop(context);
                  });
                },
                trailing: widget.persistedCache.isEmpty
                    ? null
                    : Icon(Icons.arrow_forward_ios,
                        color: ThemeColors(
                          dark: ThemeManager.darkTheme.textTheme.caption!.color!,
                          light: ThemeManager.lightTheme.textTheme.caption!.color!,
                        ).of(context)),
              ),
              color: widget.listTileColors?.of(context) ??
                  ThemeColors(
                    dark: Color(0xAA000000),
                    light: Color(0xAAffffff),
                  ).of(context),
            ),
          ),
        ));
    return result;
  }

  /// When the user taps this the keyboard will disappear and any text in the TextField is added to the cache
  Widget _submitIcon(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.move_to_inbox,
        size: _buttonSize,
      ),
      onDoubleTap: () {
        _textEditingController.clear();
      },
      onTap: () {
        SystemSound.play(SystemSoundType.click);
        _cachedString = _textEditingController.text;
        widget.cachePopoverCallback(_cachedString);
        widget.persistedCache.addItem(_textEditingController.text);
        context.hideKeyboard();
      },
    );
  }

  Widget _textField(BuildContext context) {
    return Expanded(
      child: BlocBuilder(
        bloc: _cacheCubit,
        builder: (contxt, state) {
          if (state is CacheInitial) {
            //holder = '';
            //context.hideKeyboard();
          }
          if (state is CacheSelected) {
            _cachedString = state.cacheString;
          }
          debugPrint('Cached String $_cachedString');
          return TextField(
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            minLines: null,
            maxLines: null,
            key: _uniqueKey,
            controller: _textEditingController..text = _cachedString,
            onTap: () {},
            onSubmitted: (String value) {
              widget.persistedCache.addItem(value);
            },
          );
        },
      ),
    );
  }
}
