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
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<UrlConsoleCache>(builder: (_, value, __) {
      return WebviewScaffold(
        url: value.url,
        ignoreSSLErrors: true,
      );
    }));
  }
}
