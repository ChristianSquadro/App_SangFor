import 'dart:io';

import 'package:app_sangfor/cache/UrlConsoleCache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';

class WebViewConsole extends StatefulWidget {
  const WebViewConsole();

  @override
  WebViewConsoleState createState() => WebViewConsoleState();
}

class WebViewConsoleState extends State<WebViewConsole> {
  late final flutterWebviewPlugin;

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin = new FlutterWebviewPlugin();
    if (Platform.isIOS) {
      flutterWebviewPlugin.onScrollYChanged
          .listen((double offsetY) => offsetY = 2);
      flutterWebviewPlugin.onScrollXChanged
          .listen((double offsetX) => offsetX = 2);
    }

    if (Platform.isAndroid) {
      flutterWebviewPlugin.onScrollYChanged
          .listen((double offsetY) => offsetY = 0.5);
      flutterWebviewPlugin.onScrollXChanged
          .listen((double offsetX) => offsetX = 0.5);
    }
  }

  @override
  void dispose() {
    super.dispose();
    flutterWebviewPlugin.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<UrlConsoleCache>(builder: (_, value, __) {
      return WebviewScaffold(
          withZoom: true,
          useWideViewPort: true,
          withOverviewMode: true,
          url: value.url,
          ignoreSSLErrors: true,
          hidden: true,
          appBar: new AppBar(
            title: new Text("Console"),
          ));
    }));
  }
}
