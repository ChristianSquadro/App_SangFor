import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewCustom extends StatefulWidget {
  final String url;
  const WebViewCustom(this.url);

  @override
  _WebViewCustomState createState() => _WebViewCustomState(this.url);
}

class _WebViewCustomState extends State<WebViewCustom> {
  final String url;
  bool isLoading = true;

  _WebViewCustomState(this.url);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      WebView(
        initialUrl: url,
        initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
        javascriptMode: JavascriptMode.unrestricted,
        allowsInlineMediaPlayback: true,
        gestureNavigationEnabled: true,
        onPageFinished: (finish) {
          setState(() {
            isLoading = false;
          });
        },
      ),
      isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack()
    ]);
  }
}
