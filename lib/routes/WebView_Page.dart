import 'package:app_sangfor/cache/UrlConsoleCache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

class WebViewConsole extends StatefulWidget {
  const WebViewConsole();

  @override
  WebViewConsoleState createState() => WebViewConsoleState();
}

class WebViewConsoleState extends State<WebViewConsole> {
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<UrlConsoleCache>(builder: (_, value, __) {
      return InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse("https://inappwebview.dev/")),
        initialOptions: options,
        onReceivedServerTrustAuthRequest: (controller, challenge) async {
          return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
        },
      );
    }));
  }
}
