import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as HTTP;
import 'package:theme_manager/theme_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xfer/xfer.dart';

final String u =
    "https://beta.healthtrioconnect.com/oauth2/auth?response_type=code&state=123456789&client_id=BETAFHCPRewards&scope=profile%20openid%20portal.member&redirect_uri=https%3A%2F%2Fauth.kinvey.com%2Foauth2%2Fredirect&code_challenge=9mt2KtJy3fFHuLlI5eA2gOXiEanrbJwmEhYUjmRRR1k&code_challenge_method=S256";

class ScaffoldWidget extends StatefulWidget {
  ScaffoldWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ScaffoldWidget createState() => _ScaffoldWidget();
}

class _ScaffoldWidget extends ObservingStatefulWidget<ScaffoldWidget> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
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
          _sso();
        },
        tooltip: 'load',
        child: Icon(Icons.data_saver_off),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(AppLocalizations.of(context)!.helloWorld), //Example of localization
          Expanded(child: _webView())
        ],
      ),
    );
  }

  void _sso() async {
    // final url1 = "";
    // final url2 = "&scope=profile%20openid%20portal.member&redirect_uri=https%3A%2F%2Fauth.kinvey.com%2Foauth2%2Fredirect";
    // final url3 = "&code_challenge=9mt2KtJy3fFHuLlI5eA2gOXiEanrbJwmEhYUjmRRR1k&code_challenge_method=S256";
    Map<String, String> header = {
      "upgrade-insecure-requests": "1",
      "user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_2_1) AppleWebKit/537.36 (KHTML, like Gecko) Postman/8.8.0 Chrome/87.0.4280.88 Electron/11.1.1 Safari/537.36",
      "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
      "sec-fetch-site": "none",
      "sec-fetch-mode": "navigate",
      "sec-fetch-user": "?1",
      "sec-fetch-dest": "document",
      "accept-encoding": "gzip, deflate",
      "accept-language": "en-US"
    };

    final xfer = Xfer(httpPostFuture: HTTP.post, trace: true);

    final result = await xfer.post(u, headers: header);
    debugPrint('RESULT $result');
  }

  Widget _webView() {
    return Text('Wait');
    return WebView(
      initialUrl: u,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      onProgress: (int progress) {
        print("WebView is loading (progress : $progress%)");
      },
      javascriptChannels: <JavascriptChannel>{
        _toasterJavascriptChannel(context),
      },
      navigationDelegate: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          print('blocking navigation to $request}');
          return NavigationDecision.prevent;
        }
        print('allowing navigation to $request');
        return NavigationDecision.navigate;
      },
      onPageStarted: (String url) {
        print('Page started loading: $url');
      },
      onPageFinished: (String url) {
        print('Page finished loading: $url');
      },
      gestureNavigationEnabled: true,
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
