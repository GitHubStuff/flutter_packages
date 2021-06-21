import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:persisted_cache/persisted_cache.dart';
import 'package:theme_manager/theme_manager.dart';

class ScaffoldWidget extends StatefulWidget {
  ScaffoldWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ScaffoldWidget createState() => _ScaffoldWidget();
}

class _ScaffoldWidget extends ObservingStatefulWidget<ScaffoldWidget> {
  TextEditingControllerWithCache textEditingControllerWithCache = TextEditingControllerWithCache(cacheId: 'poke');
  late final TextField textField;
  late final Text _text;
  String message = 'Tap for Size';
  String instruction = 'Tap + to change the text';
  String instruction2 = 'Tap again';
  bool isFirst = true;

  @override
  initState() {
    super.initState();
    textField = TextField(
      controller: textEditingControllerWithCache,
    );
    _text = Text('WHAT IS GOING ON?');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          ThemeControlWidget(),
        ],
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isFirst = !isFirst;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _body(BuildContext context) {
    bool show = false;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(AppLocalizations.of(context)!.helloWorld), //Example of localization
          Text(
            message,
          ),
          !show
              ? Container()
              : CachePopover<String>(
                  cachedWidget: Text('Does this need to be here?'),
                  cachePopoverCallback: (newTxt) {
                    debugPrint('NEW TEXT: $newTxt');
                  },
                  cachedItems: [],
                  emptyCacheWidget: Text('WTF'),
                  onPop: () {},
                ),

          WidgetSize(
            onChange: (Size size) {
              setState(() {
                final height = context.height;
                final width = context.width;
                debugPrint('height: $height, width: $width $isFirst');
                message = 'Size - $size';
              });
            },
            child: Text(
              isFirst ? instruction : instruction2,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          CacheWidget(
            parentWidget: Text('This is the parent!'),
          ),
        ],
      ),
    );
  }
}
