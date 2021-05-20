import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewCustom extends StatefulWidget {
  final String url;
  const WebViewCustom(this.url);

  @override
  _WebViewCustomState createState() => _WebViewCustomState(this.url);
}

class _WebViewCustomState extends State<WebViewCustom> {
  final String _url;
  bool _isLoading = true;
  late WebViewController _controller;

  _WebViewCustomState(this._url);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //i'm forced to clear the cache for the ios version because there are issues the second time you invoked the webview
    if (Platform.isIOS)
      _controller.clearCache();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      WebView(
        onWebViewCreated: (WebViewController webViewController) {
    _controller = webViewController;},
        initialUrl:_url,
        userAgent: "random",
        initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
        javascriptMode: JavascriptMode.unrestricted,
        allowsInlineMediaPlayback: true,
        gestureNavigationEnabled: true,
        onPageFinished: (finish) {
          setState(() {
            _isLoading = false;
          });
        },
      ),
      _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack()
    ]);
  }
}
