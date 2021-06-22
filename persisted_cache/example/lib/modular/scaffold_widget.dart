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
  PersistedCache _persistedCache = PersistedCache(cacheId: 'biff');
  String message = 'Tap for Size';
  String instruction = 'Tap + to change the text';
  String instruction2 = 'Tap again';
  bool isFirst = true;

  @override
  initState() {
    super.initState();
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(AppLocalizations.of(context)!.helloWorld + ' ${DateTime.now()}'), //Example of localization
          // Text(
          //   message,
          // ),

          // WidgetSize(
          //   onChange: (Size size) {
          //     setState(() {
          //       final height = context.height;
          //       final width = context.width;
          //       debugPrint('height: $height, width: $width $isFirst');
          //       message = 'Size - $size';
          //     });
          //   },
          //   child: Text(
          //     isFirst ? instruction : instruction2,
          //     style: Theme.of(context).textTheme.headline4,
          //   ),
          // ),
          CachedWidget(
            persistedCache: _persistedCache,
            emptyCacheMessage: 'Nothing Cached',
            cachePopoverCallback: (data) {
              debugPrint('${DateTime.now()} DATA: $data');
            },
          ),
        ],
      ),
    );
  }
}
